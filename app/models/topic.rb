class Topic < ActiveRecord::Base
#	belongs_to :root, :class_name => "Post"
	belongs_to :prover

	has_many :posts, :dependent => :destroy
	has_many :teams, :dependent => :destroy
	has_and_belongs_to_many :categories, :dependent => :destroy

#	def root=(post)
#		post.topic = self
#		post.save!
#		write_attribute(:root_id, post.id)
#	end
end