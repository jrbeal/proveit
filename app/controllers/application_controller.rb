class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

	before_action :configure_devise_permitted_parameters, if: :devise_controller?
	before_action :authenticate_prover!, :except => [:help, :about, :contact]
	before_action :set_top_provers
	before_action :top_semi_private_debates

	def homepage

		filter = (params[:filter] || current_prover.filter).downcase

		case filter
			when Prover::TOPICS
				if params[:prover]
					@filter_results = Post.where("level = ? AND prover_id = ?", 0, params[:prover]).order(:updated_at).reverse_order
				else
					@filter_results = Post.where("level = ?", 0).order(:updated_at).reverse_order
				end
			when Prover::OPINIONS
				if params[:prover]
					@filter_results = Post.where("kind = ? AND level = ? AND prover_id = ?", Post::OPINION, 0, params[:prover]).order(:updated_at).reverse_order
				else
					@filter_results = Post.where("kind = ? AND level = ?", Post::OPINION, 0).order(:updated_at).reverse_order
				end
			when Prover::OBJECTIONS
				if params[:prover]
					@filter_results = Post.where("kind = ? AND level > ? AND prover_id = ?", Post::OPINION, 0, params[:prover]).order(:updated_at).reverse_order
				else
					@filter_results = Post.where("kind = ? AND level > ?", Post::OPINION, 0).order(:updated_at).reverse_order
				end
			when Prover::INITIATORS
				if params[:prover]
					@filter_results = Post.where("kind = ? AND prover_id = ?", Post::INITIATOR, params[:prover]).order(:updated_at).reverse_order
				else
					@filter_results = Post.where("kind = ?", Post::INITIATOR).order(:updated_at).reverse_order
				end
			when Prover::COMMENTS
				if params[:prover]
					@filter_results = Post.where("kind = ? AND prover_id = ?", Post::COMMENT, params[:prover]).order(:updated_at).reverse_order
				else
					@filter_results = Post.where("kind = ? AND level = ?", Post::COMMENT, 0).order(:updated_at).reverse_order
				end
			when Prover::FOLLOWING
				@filter_results = []
				Follow.where("owner = ?", current_prover).each do |f|
					@filter_results = @filter_results + Post.where("prover_id = ?", f.follows)
				end
			when Prover::BOOKMARKS
				@filter_results = []
				Bookmark.where("owner = ?", current_prover).each do |b|
					@filter_results = @filter_results + Post.where("id = ?", b.post)
				end
			else
				@filter_results = []
		end

		# Now exclude the private posts (of which user is not a member and that don't allow public viewing)
		@posts = []
		@filter_results.each do |p|
			unless (p.topic.private? && !(p.topic.public_viewing? || p.team_member?(current_prover)))
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