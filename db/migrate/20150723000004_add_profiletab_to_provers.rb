class AddProfiletabToProvers < ActiveRecord::Migration
  def change
		add_column :provers, :profiletab, :string
  end
end
