class AddForeignKeyParentId < ActiveRecord::Migration
  def change
		add_foreign_key :posts, :posts, column: :parent_id, on_delete: :cascade
	end
end
