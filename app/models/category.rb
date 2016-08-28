class Category < ActiveRecord::Base
	has_many :topics, through: :TopicCategory
	has_many :filters, through: :FilterCategory
end