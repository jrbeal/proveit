class Fallacy < ActiveRecord::Base
	belongs_to :folder, :class_name => "Fallacyfolder", :foreign_key => "folder"
end