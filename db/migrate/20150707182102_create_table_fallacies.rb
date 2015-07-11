class CreateTableFallacies < ActiveRecord::Migration
  def change
	  create_table :fallacyfolders do |t|
		  t.string :name
		  t.integer :parent
		end
		add_foreign_key :fallacyfolders, :fallacyfolders, column: :parent, on_delete: :cascade

	  create_table :fallacies do |t|
		  t.string :name
		  t.integer :folder
		  t.string :opinion
		  t.string :support
		  t.string :url
	  end
		add_foreign_key :fallacies, :fallacyfolders, column: :folder, on_delete: :cascade
  end
end
