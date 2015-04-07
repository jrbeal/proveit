class Topic < ActiveRecord::Base
	has_one :root, class_name: "Post"
	has_one :categories, class_name: "Category"
	has_one :team1, class_name: "Team"
	has_one :team2, class_name: "Team"
	
end
