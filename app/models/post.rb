class Post < ActiveRecord::Base
  belongs_to :topic, :class_name => "Topic"
	belongs_to :parent, :class_name =>"Post", dependent: :destroy
	belongs_to :user, :class_name => "User"

  has_many :posts, dependent: :destroy
  has_many :topics, dependent: :destroy

	OPINION = "opinion"
	INITIATOR = "initiator"
	COMMENT = "comment"
	
	validates :message, :length => { :maximum => 140 }
	validates :support, :length => { :maximum => 10000 }
	validates_inclusion_of :kind, :in => [ OPINION, INITIATOR, COMMENT ], :message => "%s is not a valid post kind."
		
	def determine_status(id)				# Determine the status for the given post by or'ing the statuses
																	# of all its children and returning the inverse.
		result = FALSE
		kids = Post.where("parent_id = ? AND kind = ?", id, OPINION)
		kids.each do |k|
			result = result | k.status	# If any of the kids are true...
		end
		return !result								# ...we return false (else true)
	end
	
	def count_children(id, kind) 		# Count the number of children (of a given kind) under the given post
		kids = Post.where("parent_id = ? AND kind = ?", id, kind)
		return kids.count
	end
	
	def count_offspring(id, kind, count)	# Recursively increment count the number of offspring under the given post
		kids = Post.where("parent_id = ? AND kind = ?", id, kind)
		kids.each do |k|
			count = count_offspring(k.id, k.kind, count) + 1
		end
		return count
	end
	
	def count_levels(id, count) 		# Recursively increment count by the number of levels above a given opinion post
		if id.present?
			p = Post.find_by id: id
			if p.kind == OPINION
				count = count_levels(p.parent_id, count) + 1
			end
		end
		return count
	end
	
	before_create do 								# First create and initialize the new post
		if self.kind == OPINION				# status, score and level are only meaningful with opinions
			self.status = TRUE
			self.score = 100
			self.level = count_levels(self.parent_id, 0)
		end
		self.views = 0
		self.children = 0
		self.offspring = 0
		self.points = 0
	end
	
	after_create do									# Then update the new post's parent...
		if self.parent_id.present?		# ...if there is one...
			parent = Post.find_by id: self.parent_id
			if self.kind == parent.kind	# ...and it's the same kind
				if parent.kind == OPINION # status and score are only meaningful with opinions
					parent.status = FALSE
					parent.score = 0
				end
				parent.children = count_children(parent.id, parent.kind)
				parent.offspring = count_offspring(parent.id, parent.kind, 0)
				parent.save!							# Commit the new post's parent
			end
		end
	end
	
	after_update do 											# Update the ancesters...
		if self.parent_id.present?					# ... if there are any
			parent = Post.find_by id: self.parent_id
			if parent.kind == OPINION
				new_status = determine_status(parent.id)
				if parent.status != new_status	# If the status is changing, reset the score...
					if new_status
						parent.score = 100					# ...to 100 if status is true...
					else
						parent.score = 0						# ...or 0 is status is false.
					end
					parent.status = new_status
				end
			end
			parent.offspring = count_offspring(parent.id, parent.kind, 0)
			parent.save!											# Commit the updated ancesters, one at a time...
		else
																				# ...until the root node is reached.
		end
	end
end
