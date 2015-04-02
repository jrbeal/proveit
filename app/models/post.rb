class Post < ActiveRecord::Base
  belongs_to :topic
	belongs_to :parent, :class_name=>"Post"
	has_many :children, :class_name=>"Post"
	
	POST_TYPES = ["opinion", "initiator", "comment"]
	
	def post_type= val
		if POST_TYPES.include? val.downcase
				write_attribute(:post_type, val.downcase)
		else
			raise ActiveRecord::RecordInvalid.new "#{val} is not a valid post type."
		end
	end
end
