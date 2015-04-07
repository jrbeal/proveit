class RenameParentColumn < ActiveRecord::Migration
  def change
		remove_column :posts, :parent, :integer
		add_column :posts, :parent_id, :integer
  end
end
