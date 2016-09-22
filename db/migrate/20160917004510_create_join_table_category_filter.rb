class CreateJoinTableCategoryFilter < ActiveRecord::Migration
  def change
		create_table :categories_filters, :id => false do |t|
			t.references :category, :null => false
			t.references :filter, :null => false
	  end
		add_index(:categories_filters, [:category_id, :filter_id], :unique => true)
	end
end
