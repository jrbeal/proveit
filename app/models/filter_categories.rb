class Filter_categories < ActiveRecord::Base
	belongs_to :filter, class_name: "Filter", :foreign_key => "filter_id"
	belongs_to :category, :class_name => "Category", :foreign_key => "category_id"
end