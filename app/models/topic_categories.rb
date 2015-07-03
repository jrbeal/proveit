class Topic_categories < ActiveRecord::Base
	belongs_to :topic, class_name: "Topic", :foreign_key => "topic_id"
	belongs_to :category, :class_name => "Category", :foreign_key => "category_id"
end