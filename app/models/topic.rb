class Topic < ActiveRecord::Base
	belongs_to :root_id, class_name: "Post", :foreign_key => "root_id", dependent: :destroy
	belongs_to :categories_id, class_name: "Category", :foreign_key => "categories_id", dependent: :destroy
	belongs_to :team1_id, class_name: "Team", :foreign_key => "team1_id", dependent: :destroy
	belongs_to :team2_id, class_name: "Team", :foreign_key => "team2_id", dependent: :destroy

  has_many :posts, dependent: :destroy
end
