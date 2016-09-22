class Group < ActiveRecord::Base
	belongs_to :owner, :class_name => Prover

	validates :name, presence: true
end
