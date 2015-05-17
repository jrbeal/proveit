class AddDefaultFilterToProvers < ActiveRecord::Migration
  def change
    add_column :provers, :default_filter, :string
  end
end
