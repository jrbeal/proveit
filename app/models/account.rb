class Account < ActiveRecord::Base
	has_many :filters
	belongs_to :group
end
