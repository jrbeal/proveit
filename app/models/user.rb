class User < ActiveRecord::Base
	has_many :filters, dependent: :destroy
	belongs_to :posts
	has_and_belongs_to_many :groups, dependent: :destroy
	has_and_belongs_to_many :teams, dependent: :destroy
end
