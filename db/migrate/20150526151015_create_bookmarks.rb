class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :owner
      t.integer :post
    end
		add_foreign_key :bookmarks, :provers, column: :owner, on_delete: :cascade
		add_foreign_key :bookmarks, :posts, column: :post, on_delete: :cascade
  end
end
