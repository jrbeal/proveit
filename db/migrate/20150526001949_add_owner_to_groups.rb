class AddOwnerToGroups < ActiveRecord::Migration
  def change
		  add_column :groups, :owner, :integer
			add_foreign_key :groups, :provers, column: :owner
  end
end
