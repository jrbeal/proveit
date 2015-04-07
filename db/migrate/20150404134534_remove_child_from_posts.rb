class RemoveChildFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :child, :integer
  end
end
