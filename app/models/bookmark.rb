class Bookmark < ActiveRecord::Base
	belongs_to :post, class_name: "Post", :foreign_key => "post"
	belongs_to :owner, :class_name => "Prover", :foreign_key => "owner"
end

def post_message
	post.message + " [" + post.prover.provername + "]"
end