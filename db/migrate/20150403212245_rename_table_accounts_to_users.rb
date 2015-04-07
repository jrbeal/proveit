class RenameTableAccountsToUsers < ActiveRecord::Migration
  def self.up
		rename_table :accounts, :users
  end

	def self.down
		rename_table :bar, :foo
	end
end
