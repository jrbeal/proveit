class CreateTableLikes < ActiveRecord::Migration
  def change
	  create_table :likes do |t|
		  t.integer :post_id
		  t.integer :prover_id
	  end
		add_foreign_key :likes, :posts, column: :post_id, on_delete: :cascade
		add_foreign_key :likes, :provers, column: :prover_id, on_delete: :cascade
  end
end
