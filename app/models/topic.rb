class Topic < ActiveRecord::Base
	belongs_to :prover
	has_many :posts, :dependent => :destroy
	has_many :teams, :dependent => :destroy
	has_and_belongs_to_many :categories, :dependent => :destroy
end