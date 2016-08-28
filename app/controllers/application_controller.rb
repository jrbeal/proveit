class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

	before_action :configure_devise_permitted_parameters, if: :devise_controller?
	before_action :authenticate_prover!, :except => [:help, :about, :contact]
	before_action :set_top_provers
	before_action :top_semi_private_debates

	def homepage
		if current_prover
			logged_in_homepage
		else
			logged_in_homepage
		end
	end

	def logged_out_homepage
		render "application/login"
	end

	def logged_in_homepage
		@verbosity = current_prover.verbosity

		@defaultfilters = Filter.where(sitedefault: true)
		@customfilters = Filter.where(sitedefault: false, prover_id: current_prover)

		length = 0
		@defaultfilters.each do |f|
			length = f.name.length if f.name.length > length
		end

		@customfilters.each do |f|
			length = f.name.length if f.name.length > length
		end

		@divider = "-" * (length * 1.5)									# This is a hack to make the divider roughly
																										# as long as the longest filter name.

		if current_prover.cur_filter.present?
			@filter = current_prover.cur_filter 					# Get user's current filter (it should exist)
		else
			@filter = Filter.find_by sitedefault: true		# or the first default filter we can find.
		end

		# First gather all posts of the specified type(s)...

		ids = []
		if @filter.opinions									# ...all OPINION posts
			Post.where(kind: Post::OPINION).each do |p|
				ids.push p.id
			end
		end
		if @filter.initiators								# ...all INITIATOR posts
			Post.where(kind: Post::INITIATOR).each do |p|
				ids.push p.id
			end
		end
		if @filter.comments									# ...all COMMENT posts
			Post.where(kind: Post::COMMENT).each do |p|
				ids.push p.id
			end
		end
		@posts = []
		@posts = Post.where(id: ids) if ids.length > 0

		# Now start filtering...
																				# First eliminate all posts outside the specified time range
		@posts = @posts.where(:updated_at => 1.day.ago..Time.now) if @filter.today && !@posts.empty?
		@posts = @posts.where(:updated_at => 1.week.ago..Time.now) if @filter.last_week && !@posts.empty?
		@posts = @posts.where(:updated_at => 1.month.ago..Time.now) if @filter.last_month && !@posts.empty?
		@posts = @posts.where(:updated_at => 1.year.ago..Time.now) if @filter.last_year && !@posts.empty?

		if @filter.following								# now eliminate those NOT created by someone user is following
			ids = []
			Follow.where(owner: current_prover).each do |f|
				Post.where(prover_id: f.follows.id).each do |p|
					ids.push p.id
				end
			end
			@posts = @posts.where(id: ids) unless @posts.empty?
		end

		if @filter.bookmarks								# now eliminate those that are NOT bookmarks
			ids = []
			Bookmark.where(owner: current_prover).each do |b|
				ids.push b.post.id
			end
			@posts = @posts.where(id: ids) unless @posts.empty?
		end

		if @filter.lone_wolf								# now eliminate those that are NOT Lone wolf
			ids = []
			@posts.each do |p|
				ids.push p.id if p.topic.lone_wolf
			end
			@posts = @posts.where(id: ids) unless @posts.empty?
		end

		if @filter.private									# now eliminate those that are NOT private...
			ids = []
			if @filter.public_viewing					# ... and do NOT allow public viewing
				if @filter.public_comments			# ... and do NOT allow public comments
					@posts.each do |p|
						ids.push p.id if p.topic.private && p.topic.public_viewing && p.topic.public_comments
					end
				else
					@posts.each do |p|
						ids.push p.id if p.topic.private && p.topic.public_viewing
					end
				end
			else
				@posts.each do |p|
					ids.push p.id if p.topic.private
				end
			end
			@posts = @posts.where(id: ids) unless @posts.empty?
		end

		ids = []
		@posts.each do |p|									# now eliminate private posts that exclude current user...
			ids.push p.id unless p.topic.private && !(p.topic.public_viewing || p.team_member?(current_prover) || current_prover.administrator)
		end
		@posts = @posts.where(id: ids) unless @posts.empty?

		fcids = []
		FilterCategory.where(filter_id: @filter.id).each do |f|
			fcids.push f.category_id					# Create an array of category ids set in current filter...
		end

		unless fcids.empty?									# now check each post and eliminate any that are NOT within a category selected.
			ids = []
			@posts.each do |p|
				TopicCategory.where(topic_id: p.topic_id).each do |t|
					ids.push p.id if fcids.include?(t.category_id)
				end
			end
			@posts = @posts.where(id: ids) unless ids.empty?
		end
																																													# Now eliminate all posts....
		@posts = @posts.where(prover_id: @filter.who_id) if @filter.who_id && !@posts.empty?	# ...not created by specified user...
		@posts = @posts.where.not(parent_id: nil) if @filter.has_parent	&& !@posts.empty?			# ...that are parentless...
		@posts = @posts.where(parent_id: nil) if @filter.has_no_parent	&& !@posts.empty?			# ...that have parents...
		@posts = @posts.where(status: false) if @filter.contested	&& !@posts.empty?						# ...that are false...
		@posts = @posts.where(status: true) if @filter.uncontested && !	@posts.empty?					# ...that are true...
		@posts = @posts.where(level: 0) if @filter.level_zero	&& !@posts.empty?								# ...that are non-zero level...
		@posts = @posts.where.not(level: 0) if @filter.level_nonzero && !@posts.empty?				# ...that are zero level

		# Now sort the results...

		order = "desc" if @filter.descending
		order = "asc" unless @filter.descending
		@posts = @posts.order(updated_at: order) if @filter.sort_by_updated_at && !@posts.empty?
		@posts = @posts.order(created_at: order) if @filter.sort_by_created_at && !@posts.empty?
		@posts = @posts.order(views: order) if @filter.sort_by_views && !@posts.empty?
		@posts = @posts.order(points: order) if @filter.sort_by_votes && !@posts.empty?

		@posts.each do |p|									# One final pass to build...
			p.create_team_lists								# ...the team lists (for private posts)
			p.create_category_lists						# ...and the category lists
		end
	end																		# Whatever remains gets displayed to the home page.

	protected

	def configure_devise_permitted_parameters
		registration_params = [:first_name, :last_name, :email, :password, :password_confirmation, :provername]

		if params[:action] == 'update'
			devise_parameter_sanitizer.for(:account_update) {
				|u| u.permit(registration_params << :current_password)
			}
		elsif params[:action] == 'create'
			devise_parameter_sanitizer.for(:sign_up) {
				|u| u.permit(registration_params)
			}
		end
	end

	def set_top_provers
		@top_provers = Prover.all.order(:rating).limit(20).reverse_order
	end

	def top_semi_private_debates
		@top_topics = Topic.where(private: true, public_comments: true).limit(10).order(:updated_at).reverse_order
	end

end