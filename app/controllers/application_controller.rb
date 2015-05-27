class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

	before_action :configure_devise_permitted_parameters, if: :devise_controller?
	before_action :authenticate_prover!
	before_action :set_top_provers

	def homepage
		filter = (params[:filter] || current_prover.filter).downcase

		case filter
			when Prover::TOPICS
				@topics = Topic.all
				@posts = []
				@topics.each do |topic|
					@posts.push topic.root_id
				end
			when Prover::OPINIONS
				if params[:prover]
					@posts = Post.where("kind = ? AND level = ? AND prover_id = ?", Post::OPINION, 0, params[:prover])
				else
					@posts = Post.where("kind = ? AND level = ?", Post::OPINION, 0)
				end
			when Prover::OBJECTIONS
				if params[:prover]
					@posts = Post.where("kind = ? AND level > ? AND prover_id = ?", Post::OPINION, 0, params[:prover])
				else
					@posts = Post.where("kind = ? AND level > ?", Post::OPINION, 0)
				end
			when Prover::INITIATORS
				if params[:prover]
					@posts = Post.where("kind = ? AND prover_id = ?", Post::INITIATOR, params[:prover])
				else
					@posts = Post.where("kind = ?", Post::INITIATOR)
				end
			when Prover::COMMENTS
				if params[:prover]
					@posts = Post.where("kind = ? AND prover_id = ?", Post::COMMENT, params[:prover])
				else
					@posts = Post.where("kind = ? AND level = ?", Post::COMMENT, 0)
				end
			when Prover::FOLLOWING
				@posts = []
				Follow.where("owner = ?", current_prover).each do |f|
					@posts = @posts + Post.where("prover_id = ?", f.follows)
				end
			when Prover::BOOKMARKS
				@posts = []
			else
				@posts = []
		end

		# A more sophisticated sort to come...
    @posts.sort! { |a,b| b.updated_at <=> a.updated_at }
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
end