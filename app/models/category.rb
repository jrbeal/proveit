class Category < ActiveRecord::Base
	has_and_belongs_to_many :topics
	has_and_belongs_to_many :filters
	before_destroy { topics.clear }
	before_destroy { filters.clear }
end