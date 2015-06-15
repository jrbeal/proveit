module ApplicationHelper
	def already_following(prover_id)
		(Follow.where(:owner => current_prover.id, :follows => prover_id)).size > 0
	end

	def already_bookmarked(post)
		(Bookmark.where(:owner => current_prover.id, :post => post)).size > 0
	end

	def create_team_lists (post)
		if post.topic.private?
			case post.kind
				when Post::OPINION
					puts "Here1"
					if post.topic.use_teams?
						puts "Here2"
						post.team1type = Team::AGREE.capitalize
						post.team2type = Team::DISAGREE.capitalize
						if post.level.even?
							puts "Here3"
							post.team1 = Team.where("topic_id = ? AND team_type = ?", post.topic_id, Team::AGREE)
							post.team2 = Team.where("topic_id = ? AND team_type = ?", post.topic_id, Team::DISAGREE)
						else
							puts "Here4"
							post.team1 = Team.where("topic_id = ? AND team_type = ?", post.topic_id, Team::DISAGREE)
							post.team2 = Team.where("topic_id = ? AND team_type = ?", post.topic_id, Team::AGREE)
						end
					else
						puts "Here5"
						post.team1type = Team::PARTICIPANT.capitalize.pluralize
						post.team1 = Team.where("topic_id = ?", post.topic_id)
					end
				when Post::INITIATOR
					if post.topic.use_teams?
						post.team1type = Team::TEAM1.capitalize
						post.team2type = Team::TEAM2.capitalize
						post.team1 = Team.where("topic_id = ? AND team_type = ?", post.topic_id, Team::TEAM1)
						post.team2 = Team.where("topic_id = ? AND team_type = ?", post.topic_id, Team::TEAM2)
					else
						post.team1type = Team::PARTICIPANT.capitalize.pluralize
						post.team1 = Team.where("topic_id = ?", post.topic_id)
					end
				when Post::COMMENT
					post.team1type = Team::PARTICIPANT.capitalize.pluralize
					post.team1 = Team.where("topic_id = ?", post.topic_id)
				else
					post.team1type = "Error"
					post.team2type = "Error"
					post.team1 = []
					post.team2 = []
			end
		end
	end

end
