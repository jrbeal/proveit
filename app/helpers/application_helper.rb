module ApplicationHelper
	def following(prover_id)
		current_prover.follows? Prover.find(prover_id)
	end

	def bookmarked(post)
		(Bookmark.where(:owner => current_prover.id, :post => post)).size > 0
	end

	def liked(post)
		(Like.where(:prover => current_prover.id, :post => post, :likes => true)).size > 0
	end

	def disliked(post)
		(Like.where(:prover => current_prover.id, :post => post, :likes => false)).size > 0
	end
end