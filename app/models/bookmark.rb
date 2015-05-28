class Bookmark < ActiveRecord::Base
	belongs_to :post, class_name: "Post", :foreign_key => "post", dependent: :destroy
	belongs_to :owner, class_name: "Prover", :foreign_key => "owner", dependent: :destroy
end

def post_message
	post.prover.provername + ": " + post.message
end
