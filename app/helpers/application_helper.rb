module ApplicationHelper
	def already_following(post)
		(Follow.where(:owner => current_prover.id, :follows => post.prover_id)).size > 0
	end

	def already_bookmarked(post)
		(Bookmark.where(:owner => current_prover.id, :post => post)).size > 0
	end
end
