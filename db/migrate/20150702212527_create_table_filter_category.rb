class CreateTableFilterCategory < ActiveRecord::Migration
  def change
    create_table :filter_categories do |t|
		  t.integer :filter_id
		  t.integer :category_id
    end
		add_foreign_key :filter_categories, :filters, column: :filter_id, on_delete: :cascade
		add_foreign_key :filter_categories, :categories, column: :category_id, on_delete: :cascade
  end
end
