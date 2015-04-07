class AddPublicToFilters < ActiveRecord::Migration
  def change
		add_column :filters, :public, :boolean
  end
end
