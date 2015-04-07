class AddForeignKeys3 < ActiveRecord::Migration
  def change
    add_foreign_key :users_groups, :users
    add_foreign_key :users_groups, :groups
    add_foreign_key :users_teams, :users
    add_foreign_key :users_teams, :teams
  end
end
