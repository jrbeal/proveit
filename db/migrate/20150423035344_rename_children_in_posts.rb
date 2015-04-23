class RenameChildrenInPosts < ActiveRecord::Migration
  def change
		remove_column :posts, :children, :integer
		remove_column :posts, :offspring, :integer
		add_column :posts, :children_opinions, :integer
		add_column :posts, :offspring_opinions, :integer
		add_column :posts, :children_comments, :integer
		add_column :posts, :offspring_comments, :integer
	end
end
