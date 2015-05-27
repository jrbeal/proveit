class Follow < ActiveRecord::Base
	belongs_to :follows, class_name: "Prover", :foreign_key => "follows", dependent: :destroy
	belongs_to :owner, class_name: "Prover", :foreign_key => "owner", dependent: :destroy

	def follows_name
		follows.provername
	end

	def owner_name
		owner.provername
	end
end