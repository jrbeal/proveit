class Fallacyfolder < ActiveRecord::Base
	belongs_to :parent, :class_name => "Fallacyfolder", :foreign_key => "parent"
end