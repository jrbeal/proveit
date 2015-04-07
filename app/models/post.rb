class Post < ActiveRecord::Base
  has_one :topic
	belongs_to :parent, :class_name=>"Post"
	has_many :children, :class_name=>"Post"
	has_one :user
	
	def initialize(parent_id, topic_id, user_id, message, support, type)
		self.parent_id = parent_id
		self.topic_id = topic_id
		self.user_id = user_id
		self.message = message
		self.support = support
		self.type = type
	end
	
	validates :message, :length => { :maximum => 140 }
	validates :support, :length => { :maximum => 10000 }
	validates_inclusion_of :type, :in => %w( opinion initiator comment ), :message => "%s is not a valid post type."
		
	def recalculate_status
		# return inverse of all children statuses or'ed together (be careful to only check children of type "opinion")
	end
	
	after_validation do
		after_create do
			if self.type = "opinion"
				self.status = true # n/a if type = "comment" or "initiator"
				self.score = 100.0 # n/a if type = "comment" or "initiator"
			end
			self.views = 0
			self.children = 0
			self.offspring = 0
			self.points = 0
			
			if self.parent.present?
				p = self.parent
				self.level = p.level + 1
#				puts "my parent was active at #{p.updated_at}"
				if type = "opinion"
					p.status = false # n/a if type = "comment" or "initiator"
					p.score = 0.0    # n/a if type = "comment" or "initiator"
				end
				p.children += 1
				p.offspring += 1
				p.save!
			else
				self.level = 0
			end
		end
		
		after_update do
			if self.parent.present?
				p = self.parent
				if self.type = "opinion"
					new_status = recalculate_status(p)
					if p.status != new_status # is the status changing?
						if p.status
							p.score = 100.0
						else
							p.score = 0.0
						end
						p.status = new_status
					end
				end
				p.offspring += 1
				p.save!
			else
				puts "This is the root node!"
			end
		end
	end
	
	
end
