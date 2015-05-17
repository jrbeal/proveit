class AddLastNameToProvers < ActiveRecord::Migration
  def change
    add_column :provers, :last_name, :string
  end
end
