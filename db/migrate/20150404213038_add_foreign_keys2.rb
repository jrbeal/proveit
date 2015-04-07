class AddForeignKeys2 < ActiveRecord::Migration
  def change
    add_foreign_key :teams, :topics
		remove_column :teams, :account_id, :integer
		add_column :teams, :user_id, :integer
		add_foreign_key :teams, :users
  end
end
