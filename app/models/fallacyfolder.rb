class Fallacyfolder < ActiveRecord::Base
	belongs_to :parent, :class_name => "Fallacyfolder", :foreign_key => "parent"
	has_many :fallacies, :foreign_key => "folder"
	has_many :fallacyfolders, :foreign_key => "parent"
end