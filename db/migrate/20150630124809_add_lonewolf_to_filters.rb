class AddLonewolfToFilters < ActiveRecord::Migration
  def change
	  add_column :filters, :lonewolf, :boolean
  end
end
