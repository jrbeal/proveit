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

	# def create_team_lists (post)
	# 	if post.topic.private?
	# 		case post.kind
	# 			when Post::OPINION
	# 				puts "Here1"
	# 				if post.topic.use_teams?
	# 					puts "Here2"
	# 					post.team1type = Team::AGREE.capitalize
	# 					post.team2type = Team::DISAGREE.capitalize
	# 					if post.level.even?
	# 						puts "Here3"
	# 						post.team1 = Team.where("topic_id = ? AND team_type = ?", post.topic_id, Team::AGREE)
	# 						post.team2 = Team.where("topic_id = ? AND team_type = ?", post.topic_id, Team::DISAGREE)
	# 					else
	# 						puts "Here4"
	# 						post.team1 = Team.where("topic_id = ? AND team_type = ?", post.topic_id, Team::DISAGREE)
	# 						post.team2 = Team.where("topic_id = ? AND team_type = ?", post.topic_id, Team::AGREE)
	# 					end
	# 				else
	# 					puts "Here5"
	# 					post.team1type = Team::PARTICIPANT.capitalize.pluralize
	# 					post.team1 = Team.where("topic_id = ?", post.topic_id)
	# 				end
	# 			when Post::INITIATOR
	# 				if post.topic.use_teams?
	# 					post.team1type = Team::TEAM1.capitalize
	# 					post.team2type = Team::TEAM2.capitalize
	# 					post.team1 = Team.where("topic_id = ? AND team_type = ?", post.topic_id, Team::TEAM1)
	# 					post.team2 = Team.where("topic_id = ? AND team_type = ?", post.topic_id, Team::TEAM2)
	# 				else
	# 					post.team1type = Team::PARTICIPANT.capitalize.pluralize
	# 					post.team1 = Team.where("topic_id = ?", post.topic_id)
	# 				end
	# 			when Post::COMMENT
	# 				post.team1type = Team::PARTICIPANT.capitalize.pluralize
	# 				post.team1 = Team.where("topic_id = ?", post.topic_id)
	# 			else
	# 				post.team1type = "Error"
	# 				post.team2type = "Error"
	# 				post.team1 = []
	# 				post.team2 = []
	# 		end
	# 	end
	# end

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