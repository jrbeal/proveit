class Group < ActiveRecord::Base
  has_and_belongs_to_many :provers
	has_one :owner, :class_name => Prover

	validates :name, presence: true
  validates :name, length => { :maximum => 64 }
end
