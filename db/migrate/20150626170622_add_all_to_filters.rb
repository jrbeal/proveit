class AddAllToFilters < ActiveRecord::Migration
  def change
	  add_column :filters, :all, :boolean
  end
end
