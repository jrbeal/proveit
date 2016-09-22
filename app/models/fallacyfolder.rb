class Fallacyfolder < ActiveRecord::Base
	belongs_to :parent, :class_name => "Fallacyfolder", :foreign_key => "parent"

	has_many :fallacies, :foreign_key => "folder", :dependent => :destroy
	has_many :fallacyfolders, :foreign_key => "parent", :dependent => :destroy
end