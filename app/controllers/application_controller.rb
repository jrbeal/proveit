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
		@customfilters = Filter.where(prover_id: current_prover)

		length = 0
		@defaultfilters.each do |f|
			length = f.name.length if f.name.length > length
		end
		@customfilters.each do |f|
			length = f.name.length if f.name.length > length
		end

		@divider = "-" * (length * 1.5)

		if current_prover.cur_filter.present?
			@filter = current_prover.cur_filter 					# Get user's current filter (should exist)
		else
			@filter = Filter.find_by sitedefault: true		# or the first default filter we can find.
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
		@posts = []
		@posts = Post.where(id: ids).order(updated_at: :desc) if ids.length > 0

		if @filter.following
			ids = []
			Follow.where(owner: current_prover).each do |f|
				Post.where(prover_id: f.follows.id).each do |p|
					ids.push p.id
				end
			end
			@posts = @posts.where(id: ids).order(updated_at: :desc)
		end

		if @filter.bookmarks
			ids = []
			Bookmark.where(owner: current_prover).each do |b|
				ids.push b.post.id
			end
			@posts = @posts.where(id: ids).order(updated_at: :desc)
		end

		if @filter.lone_wolf
			ids = []
			@posts.each do |p|
				ids.push p.id if p.topic.lone_wolf
			end
			@posts = @posts.where(id: ids).order(updated_at: :desc)
		end

		if @filter.private
			ids = []
			if @filter.public_viewing
				if @filter.public_comments
					@posts.each do |p|
						ids.push p.id if (p.topic.private && p.topic.public_viewing && p.topic.public_comments)
					end
				else
					@posts.each do |p|
						ids.push p.id if current_prover.administrator || p.team_member?(current_prover) || (p.topic.private && p.topic.public_viewing)
					end
				end
			else
				@posts.each do |p|
					ids.push p.id if current_prover.administrator ||  p.team_member?(current_prover)
				end
			end

			@posts = @posts.where(id: ids).order(updated_at: :desc)
		end

		@posts = @posts.where(prover_id: @filter.who_id) if @filter.who_id
		@posts = @posts.where.not(parent_id: nil) if @filter.has_parent
		@posts = @posts.where(parent_id: nil) if @filter.has_no_parent
		@posts = @posts.where(status: false) if @filter.contested
		@posts = @posts.where(status: true) if @filter.uncontested
		@posts = @posts.where(level: 0) if @filter.level_zero
		@posts = @posts.where("level > ?", 0) if @filter.level_nonzero
		@posts = @posts.where(:created_at => 1.day.ago..Time.now) if @filter.today
		@posts = @posts.where(:created_at => 1.week.ago..Time.now) if @filter.last_week
		@posts = @posts.where(:created_at => 1.month.ago..Time.now) if @filter.last_month
		@posts = @posts.where(:created_at => 1.year.ago..Time.now) if @filter.last_year

		@posts.each do |p|
			p.create_team_lists
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