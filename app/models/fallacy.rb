class Fallacy < ActiveRecord::Base
	belongs_to :fallacyfolder, :foreign_key => "folder"
end