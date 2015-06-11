class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

	before_action :configure_devise_permitted_parameters, if: :devise_controller?
	before_action :authenticate_prover!, :except => [:help, :about, :contact]
	before_action :set_top_provers

	def homepage

		filter = (params[:filter] || current_prover.filter).downcase

		case filter
			when Prover::TOPICS
				if params[:prover]
					@filter_results = Post.where("level = ? AND prover_id = ?", 0, params[:prover])
				else
					@filter_results = Post.where("level = ?", 0)
				end
			when Prover::OPINIONS
				if params[:prover]
					@filter_results = Post.where("kind = ? AND level = ? AND prover_id = ?", Post::OPINION, 0, params[:prover])
				else
					@filter_results = Post.where("kind = ? AND level = ?", Post::OPINION, 0)
				end
			when Prover::OBJECTIONS
				if params[:prover]
					@filter_results = Post.where("kind = ? AND level > ? AND prover_id = ?", Post::OPINION, 0, params[:prover])
				else
					@filter_results = Post.where("kind = ? AND level > ?", Post::OPINION, 0)
				end
			when Prover::INITIATORS
				if params[:prover]
					@filter_results = Post.where("kind = ? AND prover_id = ?", Post::INITIATOR, params[:prover])
				else
					@filter_results = Post.where("kind = ?", Post::INITIATOR)
				end
			when Prover::COMMENTS
				if params[:prover]
					@filter_results = Post.where("kind = ? AND prover_id = ?", Post::COMMENT, params[:prover])
				else
					@filter_results = Post.where("kind = ? AND level = ?", Post::COMMENT, 0)
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

		@filter_results = @filter_results.to_a
		# A more sophisticated sort to come...
    @filter_results.sort! { |a,b| b.updated_at <=> a.updated_at }

		# Now exclude the private posts...
		@posts = []
		@filter_results.each do |p|
			if (!p.topic.private? || (p.topic.private? && (p.topic.public_viewing? || team_member(p) == true)))
				@posts.push(p)
			end
		end

		@posts.each do |p|
			if p.topic.private?
				case p.kind
					when Post::OPINION
						if p.topic.use_teams?
							p.team1type = Team::AGREE
							p.team2type = Team::DISAGREE
							p.team2 = Team.where("topic_id = ? AND team_type = ?", p.topic_id, p.team2type)
						else
							p.team1type = Team::PARTICIPANT
						end
						p.team1 = Team.where("topic_id = ? AND team_type = ?", p.topic_id, p.team1type)
					when Post::INITIATOR
						if p.topic.use_teams?
							p.team1type = Team::TEAM1
							p.team2type = Team::TEAM2
							p.team2 = Team.where("topic_id = ? AND team_type = ?", p.topic_id, p.team2type)
						else
							p.team1type = Team::PARTICIPANT
						end
						p.team1 = Team.where("topic_id = ? AND team_type = ?", p.topic_id, p.team1type)
					when Post::COMMENT
						p.team1type = Team::PARTICIPANT
						p.team1 = Team.where("topic_id = ? AND team_type = ?", p.topic_id, p.team1type)
				end
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

	def team_member(post)
		Team.exists?(:topic_id => post.topic, :prover_id => current_prover)
	end
end