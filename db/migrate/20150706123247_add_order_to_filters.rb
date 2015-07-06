class AddOrderToFilters < ActiveRecord::Migration
  def change
	  add_column :filters, :descending, :boolean
  end
end
