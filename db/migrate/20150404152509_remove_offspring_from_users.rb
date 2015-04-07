class RemoveOffspringFromUsers < ActiveRecord::Migration
  def change
		remove_column :users, :offspring, :integer
  end
end
