class Category < ActiveRecord::Base
	has_many :topics, through: :Topic_categories
	has_many :filters, through: :Filter_categories
end
