class RenameDefaultToDefaultfilter < ActiveRecord::Migration
  def change
		remove_column :filters, :default, :boolean
		add_column :filters, :defaultfilter, :boolean
  end
end
