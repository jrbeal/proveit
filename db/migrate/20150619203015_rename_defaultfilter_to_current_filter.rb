class RenameDefaultfilterToCurrentFilter < ActiveRecord::Migration
  def change
		remove_column :provers, :default_filter, :integer
		add_column :provers, :current_filter, :integer
	  add_foreign_key :provers, :filters, column: :current_filter
  end
end
