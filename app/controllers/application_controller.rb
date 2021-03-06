class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

	before_action :configure_devise_permitted_parameters, if: :devise_controller?
	before_action :authenticate_prover!, :except => [:help, :about, :contact, :news, :motivation]
	before_action :top_provers
	before_action :marquee
	before_action :top_channels

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

		@defaultfilters = Filter.where(sitedefault: true).order('name')
		@customfilters = Filter.where(sitedefault: false, prover_id: current_prover).order('name')

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


																				# Start filtering...
		@posts = Post.all.includes(:topic)
		@posts = @posts.where.not(kind: Post::OPINION) unless @filter.opinions || @posts.empty?
		@posts = @posts.where.not(kind: Post::INITIATOR) unless @filter.initiators || @posts.empty?
		@posts = @posts.where.not(kind: Post::COMMENT) unless @filter.comments || @posts.empty?

																				# Now eliminate all posts outside the specified time range
		@posts = @posts.where(:updated_at => 1.day.ago..Time.now) if @filter.today && !@posts.empty?
		@posts = @posts.where(:updated_at => 1.week.ago..Time.now) if @filter.last_week && !@posts.empty?
		@posts = @posts.where(:updated_at => 1.month.ago..Time.now) if @filter.last_month && !@posts.empty?
		@posts = @posts.where(:updated_at => 1.year.ago..Time.now) if @filter.last_year && !@posts.empty?

		if @filter.following								# now eliminate those NOT created by someone user is following
			ids = []
			current_prover.followers.each do |p|
				ids.push p.id
			end
			@posts = @posts.where(prover_id: ids) unless @posts.empty?
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
																																													# Now eliminate all posts....
		@posts = @posts.where(prover_id: @filter.who_id) if @filter.who_id && !@posts.empty?	# ...not created by specified user...
		@posts = @posts.where.not(parent_id: nil) if @filter.has_parent	&& !@posts.empty?			# ...that are parentless...
		@posts = @posts.where(parent_id: nil) if @filter.has_no_parent && !@posts.empty?			# ...that have parents...
		@posts = @posts.where(status: false) if @filter.contested	&& !@posts.empty?						# ...that are false...
		@posts = @posts.where(status: true) if @filter.uncontested && !	@posts.empty?					# ...that are true...
		@posts = @posts.where(level: 0) if @filter.level_zero	&& !@posts.empty?								# ...that are non-zero level...
		@posts = @posts.where.not(level: 0) if @filter.level_nonzero && !@posts.empty?				# ...that are zero level

		# Now sort the results...
		order = @filter.descending ? :desc : :asc
		@posts = @posts.order(updated_at: order) if @filter.sort_by_updated_at && !@posts.empty?
		@posts = @posts.order(created_at: order) if @filter.sort_by_created_at && !@posts.empty?
		@posts = @posts.order(views: order) if @filter.sort_by_views && !@posts.empty?
		@posts = @posts.order(points: order) if @filter.sort_by_votes && !@posts.empty?

		if @filter.sort_by_scores && !@posts.empty?
			@posts = @posts.sort do |p1, p2|
				t1 = p1.topic.score || 0
				t2 = p2.topic.score || 0
				t2 <=> t1
			end
		end

		# Now eliminate all posts not within any of the categories selected. (Had to do this last because "select" is NOT
		# an ActiveRecord method and it returns a standard Ruby array instead of an ActiveRecord Relation.)
		@posts = @posts.select { |p| (p.topic.categories & @filter.categories).any? } if @filter.categories.any?

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

	def top_provers
		@top_provers = Prover.all.order(:rating).limit(20).reverse_order
	end

	def top_channels
		@channels = Topic.where(kind: Post::COMMENT, private: false, lone_wolf: true)		# Get all channels
		@channels.each do |c|																														# For each channel...
			@posts = Post.where(topic_id: c, prover_id: c.prover_id)  										# ...get all posts submitted by OP
			c.score = 0.0;																																# ...Initialize channel score.
			@posts.each do |p|																														# For each post...
				c.score = c.score + p.score																									# ...add up the scores.
			end
			c.save
		end
		@top_channels = @channels.order(:score).limit(10).reverse unless @channels.empty?
	end

	def marquee
		@topics = Topic.where(private: true, public_viewing: true, public_comments: true)

		@topics.each do |t|
			@posts = Post.where(topic_id: t)	# includes comments (on purpose)
			t.score = 0.0;
			@posts.each do |p|
				t.score = t.score + p.score
			end
			t.save
		end
		@marquee = @topics.order(:score).limit(10).reverse unless @topics.empty?
	end
end