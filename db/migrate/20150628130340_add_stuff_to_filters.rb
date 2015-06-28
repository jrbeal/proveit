class AddStuffToFilters < ActiveRecord::Migration
  def change
		remove_column :filters, :sort_by_date, :boolean
		add_column :filters, :sort_by_updated_at, :boolean
		add_column :filters, :sort_by_created_at, :boolean
		add_column :filters, :who_id, :integer
		add_foreign_key :filters, :provers, column: :who_id
  end
end
