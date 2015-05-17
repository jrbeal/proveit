class AddFirstNameToProvers < ActiveRecord::Migration
  def change
    add_column :provers, :first_name, :string
  end
end
