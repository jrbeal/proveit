class ChangePostParent < ActiveRecord::Migration
  def change
		remove_column :posts, :parent_post_id, :integer
		add_column :posts, :parent, :integer
  end
end
