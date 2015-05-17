class AddOffspringCollapsedToProvers < ActiveRecord::Migration
  def change
    add_column :provers, :offspring_collapsed, :boolean
  end
end
