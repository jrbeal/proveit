module FollowsHelper
	def follows_id
		follows.id
	end

	def follows_name
		follows.provername
	end

	def owner_id
		owner.id
	end

	def owner_name
		owner.provername
	end
end
