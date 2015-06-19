class AddDefaultToFilters < ActiveRecord::Migration
  def change
		add_column :filters, :default, :boolean
  end
end
