class Topic < ActiveRecord::Base
	has_one :root_id, class_name: "Post"
	has_one :categories_id, class_name: "Category"
	has_one :team1_id, class_name: "Team"
	has_one :team2_id, class_name: "Team"
	
end
