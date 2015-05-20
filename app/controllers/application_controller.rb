class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

	before_action :configure_devise_permitted_parameters, if: :devise_controller?
	before_action :authenticate_prover!

	def homepage
		case current_prover.filter
			when Prover::TOPICS
				@topics = Topic.all
				@posts = []
				@topics.each do |topic|
					@posts.push topic.root_id
				end
			when Prover::OPINIONS
				@posts = Post.where("kind = ? AND level = ?", Post::OPINION, 0)
			when Prover::OBJECTIONS
				@posts = Post.where("kind = ? AND level > ?", Post::OPINION, 0)
			when Prover::INITIATORS
				@posts = Post.where("kind = ?", Post::INITIATOR)
			when Prover::COMMENTS
				@posts = Post.where("kind = ? AND level = ?", Post::COMMENT, 0)
			when Prover::FOLLOWING
			when Prover::BOOKMARKS
		end

    # @posts.sort! { |a,b| b.views <=> a.views }
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
end