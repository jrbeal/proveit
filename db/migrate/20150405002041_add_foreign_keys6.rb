class AddForeignKeys6 < ActiveRecord::Migration
  def change
    remove_column :posts, :parent_id, :integer
		add_column :posts, :parent, :integer
    add_foreign_key :posts, :posts, column: :parent
    add_foreign_key :posts, :topics
  end
end
