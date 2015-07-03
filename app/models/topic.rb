class Topic < ActiveRecord::Base
	belongs_to :root, :class_name => "Post", :foreign_key => "root_id", dependent: :destroy
	belongs_to :prover

  has_many :posts, dependent: :destroy
	has_many :teams, dependent: :destroy
	has_many :provers, through: :teams
	has_many :categories, through: :Topic_categories

	def root=(post)
		post.topic = self
		post.save!
		write_attribute(:root_id, post.id)
	end
end