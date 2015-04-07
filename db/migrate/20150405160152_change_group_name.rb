class ChangeGroupName < ActiveRecord::Migration
  def change
		remove_column :groups, :group_name, :string
		add_column :groups, :name, :string
  end
end
