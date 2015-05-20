class RenameDefaultFilterInProvers < ActiveRecord::Migration
  def change
		remove_column :provers, :default_filter, :string
		add_column :provers, :filter, :string
  end
end
