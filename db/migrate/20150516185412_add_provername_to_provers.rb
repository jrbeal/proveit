class AddProvernameToProvers < ActiveRecord::Migration
  def change
    add_column :provers, :provername, :string
    add_index :provers, :provername, unique: true
  end
end
