class AddColumnsToFilters < ActiveRecord::Migration
  def change
	  add_column :filters, :has_no_parent, :boolean
	  add_column :filters, :last_year, :boolean
  end
end
