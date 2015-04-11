class RemoveActivityAtFromPosts < ActiveRecord::Migration
  def change
		remove_column :posts, :activity_at, :timestamp
	end
end
