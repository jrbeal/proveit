class AddAdministratorToProvers < ActiveRecord::Migration
  def change
		add_column :provers, :administrator, :boolean
  end
end
