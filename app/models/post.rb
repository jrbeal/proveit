class Post < ActiveRecord::Base
	belongs_to :parent, :class_name => "Post", :foreign_key => "parent_id"
	belongs_to :prover, :class_name => "Prover", :foreign_key => "prover_id"
	belongs_to :topic, :class_name => "Topic", :foreign_key	=> "topic_id"

	has_many :bookmarks, :foreign_key => "post", :dependent => :destroy
	has_many :likes, :dependent => :destroy
	has_many :posts, :foreign_key => "parent_id", :dependent => :destroy

	OPINION = "opinion"
	INITIATOR = "initiator"
	COMMENT = "comment"

	SECONDS_IN_WEEK = 60*60*24*7

	validates :message, :length => { :maximum => 140, :minimum => 1 }
	validates :support, :length => { :maximum => 10000 }
	validates_inclusion_of :kind, :in => [ OPINION, INITIATOR, COMMENT ], :message => "%s is not a valid post kind."

	def opinion_repliable
		instance_variable_get('@opinion_repliable')
	end

	def opinion_repliable=(val)
		instance_variable_set('@opinion_repliable', val)
	end

	def comment_repliable
		instance_variable_get('@comment_repliable')
	end

	def comment_repliable=(val)
		instance_variable_set('@comment_repliable', val)
	end

	def team1
		instance_variable_get('@team1')
	end

	def team1=(val)
		instance_variable_set('@team1', val)
	end

	def team2
		instance_variable_get('@team2')
	end

	def team2=(val)
		instance_variable_set('@team2', val)
	end

	def team1type
		instance_variable_get('@team1type')
	end

	def team1type=(val)
		instance_variable_set('@team1type', val)
	end

	def team2type
		instance_variable_get('@team2type')
	end

	def team2type=(val)
		instance_variable_set('@team2type', val)
	end

	def team_member?(current_prover)
		!!Team.exists?(:topic_id => self.topic, :prover_id => current_prover)
	end

	def which_team(current_prover)
		team = Team.where(:topic_id => self.topic, :prover_id => current_prover).first.team_type
	end

	def determine_status(id)				# Determine the status for the given post by or'ing the statuses
																	# of all its children and returning the inverse.
		result = FALSE
		kids = Post.where(parent_id: id, kind: OPINION)
    kids.each do |k|
 			result = result | k.status	# If any of the kids are true...
    end
		return !result								# ...we return false (else true)
	end
	
	def count_children(id, kind) 		# Count the number of children (of a given kind) under the given post
		puts "counting children for #{id}"
		kids = Post.where(parent_id: id, kind: kind)
		kids.count
	end

	def count_offspring(id, kind, count)	# Recursively increment count the number of offspring under the given post
		puts "Counting offspring for #{id}"
		kids = Post.where(parent_id: id, kind: kind)
		kids.each do |k|
			count = count_offspring(k.id, k.kind, count) + 1
		end
		count
	end

	def categories
		topic.categories
	end

	def categories=(val)
		topic.categories = val
	end

	def create_category_lists
		topic.categories
	end

	def create_team_lists
		if self.topic.private?
			case self.kind
				when Post::OPINION																									# Special case:
					if self.parent.present? && self.parent.kind == Post::INITIATOR		# If parent is an initiator...
						if self.topic.use_teams?																				# and topic is using teams...
							if self.parent.which_team(self.prover_id) == Team::TEAM1			# and post's user is on initiator's Team 1
								self.team1type = Team::AGREE.capitalize
								self.team1 = Team.where(topic_id: self.parent.topic_id, team_type: Team::TEAM1)
								self.team2type = Team::DISAGREE.capitalize
								self.team2 = Team.where(topic_id: self.parent.topic_id, team_type: Team::TEAM2)
							else																													# else post's user is on Team 2.
								self.team1type = Team::AGREE.capitalize
								self.team1 = Team.where(topic_id: self.parent.topic_id, team_type: Team::TEAM2)
								self.team2type = Team::DISAGREE.capitalize
								self.team2 = Team.where(topic_id: self.parent.topic_id, team_type: Team::TEAM1)
							end
						else																														# Topic is NOT using teams.
							self.team1type = Team::PARTICIPANT.capitalize.pluralize				# So just create a participant list.
							self.team1 = Team.where(topic_id: self.topic_id)
						end
					else																															# Normal case...
						if self.topic.use_teams?
							self.team1type = Team::AGREE.capitalize
							self.team2type = Team::DISAGREE.capitalize
							if self.level.even?
								self.team1 = Team.where(topic_id: self.topic_id, team_type: Team::AGREE)
								self.team2 = Team.where(topic_id: self.topic_id, team_type: Team::DISAGREE)
							else
								self.team1 = Team.where(topic_id: self.topic_id, team_type: Team::DISAGREE)
								self.team2 = Team.where(topic_id: self.topic_id, team_type: Team::AGREE)
							end
						else
							self.team1type = Team::PARTICIPANT.capitalize.pluralize
							self.team1 = Team.where(topic_id: self.topic_id)
						end
					end
				when Post::INITIATOR
					if self.topic.use_teams?
						self.team1type = Team::TEAM1.capitalize
						self.team2type = Team::TEAM2.capitalize
						self.team1 = Team.where(topic_id: self.topic_id, team_type: Team::TEAM1)
						self.team2 = Team.where(topic_id: self.topic_id, team_type: Team::TEAM2)
					else
						self.team1type = Team::PARTICIPANT.capitalize.pluralize
						self.team1 = Team.where(topic_id: self.topic_id)
					end
				when Post::COMMENT
					self.team1type = Team::PARTICIPANT.capitalize.pluralize
					self.team1 = Team.where(topic_id: self.topic_id)
				else
					self.team1type = "Error"
					self.team2type = "Error"
					self.team1 = []
					self.team2 = []
			end
		end
	end

	def count_levels(current, count) 		# Recursively increment count by the number of levels above a given post
		if current.parent.present?
			p = Post.find_by id: current.parent
			if p.kind == current.kind				# Keep going until the post kind differs from its parent
				count = count_levels(p, count) + 1
			end
		end
		return count
	end

	def self::update_post_scores()
		decay_factor = Siteconfig.find_by(:name => "decay_factor")
		Post.all.each do |p|
			case p.kind
				when OPINION
					if (p.status)
						weeks_since_last_update = (Time.now - p.updated_at) / SECONDS_IN_WEEK
						p.update_column(:score, 100*(decay_factor.floatvalue**weeks_since_last_update))
					else
						p.update_column(:score, 0.0)
					end
				when COMMENT		# This is only meaningful for channels
					weeks_since_created = (Time.now - p.created_at) / SECONDS_IN_WEEK
					p.update_column(:score, 100*(decay_factor.floatvalue**weeks_since_created))
			end
		end
	end
	
	before_create do 								# First create and initialize the new post
		self.status = TRUE if self.kind == OPINION				# status is only meaningful with opinions
		self.score = 100.0 unless self.kind == INITIATOR	# score is not meaningful with initiators
		self.level = count_levels(self, 0)
		self.views = 0
		self.children_opinions=0
    self.children_comments=0
		self.offspring_opinions=0
    self.offspring_comments=0
		self.points = 0
	end

	def after_save_callback
		Rails.logger.info "After save for #{self.id}"

		if self.parent.present?					# ... if there are any...
			parent = self.parent
			case parent.kind
				when OPINION
					case self.kind
						when COMMENT
							parent.offspring_comments = count_offspring(parent.id, COMMENT, 0)
							parent.children_comments = count_children(parent.id, COMMENT)
						when OPINION
							new_status = determine_status(parent.id)
							if parent.status != new_status		# If the status is changing, reset the score...
								if new_status
									parent.score = 100.0					# ...to 100 if new status is true...
								else
									parent.score = 0.0						# ...or 0 if new status is false.
								end
								parent.status = new_status
							end
							parent.offspring_opinions = count_offspring(parent.id, OPINION, 0)
							parent.children_opinions = count_children(parent.id, OPINION)
					end
				when COMMENT
					case self.kind
						when COMMENT
							parent.offspring_comments = count_offspring(parent.id, COMMENT, 0)
							parent.children_comments = count_children(parent.id, COMMENT)
					end
				when INITIATOR
					case self.kind
						when COMMENT
							parent.offspring_comments = count_offspring(parent.id, COMMENT, 0)
							parent.children_comments = count_children(parent.id, COMMENT)
						when OPINION
							parent.offspring_opinions = count_offspring(parent.id, OPINION, 0)
							parent.children_opinions = count_children(parent.id, OPINION)
						else
					end
				else
			end
			parent.save!                      # Commit the updated post
		else
			# ...until the root node is reached
		end
		Prover.update_ratings
		Prover.update_rankings
	end

	after_create do									# Then update the new post's parent...
		if self.parent.present?	    	# ...if there is one...
			parent = self.parent
      if self.kind == OPINION && parent.kind == OPINION   # status and score are only meaningful with opinions
        parent.status = FALSE
        parent.score = 0.0
      end
      parent.save!							  # Commit the new post's parent
		end

		Prover.update_ratings
		Prover.update_rankings
	end

	after_destroy :after_save_callback

	after_save :after_save_callback
end
