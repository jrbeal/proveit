class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

	before_action :configure_devise_permitted_parameters, if: :devise_controller?
	before_action :authenticate_prover!, :except => [:help, :about, :contact]
	before_action :set_top_provers
	before_action :top_semi_private_debates

	def homepage

		@defaultfilters = Filter.where(sitedefault: true)
		# @customfilters = Filter.where(prover_id: current_prover.id)
		@customfilters = Filter.where(sitedefault: false)		# Do this until custom filters are implemented

		length = 0
		@defaultfilters.each do |f|
			length = f.name.length if f.name.length > length
		end
		@customfilters.each do |f|
			length = f.name.length if f.name.length > length
		end

		@divider = "-" * length

		if current_prover.cur_filter.present?
			@filter = current_prover.cur_filter 																# Get user's current filter...
		else
			@filter = Filter.find_by(name: Filter::TOPICS, sitedefault: true)		# or just use "Topics" as a default
		end

		ids = []
		if @filter.opinions
			Post.where(kind: Post::OPINION).each do |p|
				ids.push p.id
			end
		end
		if @filter.initiators
			Post.where(kind: Post::INITIATOR).each do |p|
				ids.push p.id
			end
		end
		if @filter.comments
			Post.where(kind: Post::COMMENT).each do |p|
				ids.push p.id
			end
		end
		@filter_results = []
		@filter_results = Post.where(id: ids).order(updated_at: :desc) if ids.length > 0

		if @filter.following
			ids = []
			Follow.where(owner: current_prover).each do |f|
				Post.where(prover_id: f.follows.id).each do |p|
					ids.push p.id
				end
			end
			@filter_results = @filter_results.where(id: ids).order(updated_at: :desc)
		end

		if @filter.bookmarks
			ids = []
			Bookmark.where(owner: current_prover).each do |b|
				ids.push b.post.id
			end

			@filter_results = @filter_results.where(id: ids).order(updated_at: :desc)
		end

		unless @filter.sitedefault  																						# This is temporary until custom filters are working...
			@filter_results = @filter_results.where(prover_id: current_prover.id)	# sitedefault "false" means it's a customfilter (for now)
		end																																			# This filters out all but the current user's posts

		# Now filter stuff out...
		@filter_results = @filter_results.where.not(parent_id: nil) if @filter.has_parent
		@filter_results = @filter_results.where(parent_id: nil) if @filter.has_no_parent
		@filter_results = @filter_results.where(status: false) if @filter.contested
		@filter_results = @filter_results.where(status: true) if @filter.uncontested
		@filter_results = @filter_results.where(level: 0) if @filter.level_zero
		@filter_results = @filter_results.where("level > ?", 0) if @filter.level_nonzero
		@filter_results = @filter_results.where(:created_at => 1.day.ago..Time.now) if @filter.today
		@filter_results = @filter_results.where(:created_at => 1.week.ago..Time.now) if @filter.last_week
		@filter_results = @filter_results.where(:created_at => 1.month.ago..Time.now) if @filter.last_month
		@filter_results = @filter_results.where(:created_at => 1.year.ago..Time.now) if @filter.last_year

		# Now exclude the private posts (of which user is not a member and that don't allow public viewing)
		@posts = []
		@filter_results.each do |p|
			if (current_prover.administrator || !(p.topic.private? && !(p.topic.public_viewing? || p.team_member?(current_prover))))
				# For private posts, create_team_lists builds a list of names for each team associated with the post's
				# topic and generates the team type names to be used in the select_tag pull down menus of each post.
				p.create_team_lists
				@posts.push(p)
			end
		end
	end

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
		@top_topics = Topic.where("private = ? AND public_comments = ?", true, true).limit(10).order(:updated_at).reverse_order
	end

end