class AddKidtypeToProvers < ActiveRecord::Migration
  def change
		add_column :provers, :kidtype, :string
  end
end
