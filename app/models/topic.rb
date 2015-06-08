class Topic < ActiveRecord::Base
	belongs_to :root_id, class_name: "Post", :foreign_key => "root_id", dependent: :destroy
	belongs_to :categories_id, class_name: "Category", :foreign_key => "categories_id", dependent: :destroy

  has_many :posts, dependent: :destroy
	has_many :teams, dependent: :destroy
	has_many :provers, through: :teams
end
