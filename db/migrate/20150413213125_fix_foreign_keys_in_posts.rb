class FixForeignKeysInPosts < ActiveRecord::Migration
  def change
		remove_foreign_key :posts, column: :topic_id
		remove_foreign_key :posts, column: :parent
		remove_foreign_key :posts, column: :user_id
		add_foreign_key :posts, :topics, column: :topic_id, on_delete: :cascade
		add_foreign_key :posts, :posts, column: :parent, on_delete: :cascade
		add_foreign_key :posts, :users, column: :user_id, on_delete: :cascade
	end
end
