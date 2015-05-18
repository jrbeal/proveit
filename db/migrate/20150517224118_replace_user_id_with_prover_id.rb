class ReplaceUserIdWithProverId < ActiveRecord::Migration
  def change
	  remove_column :users_groups, :user_id, :integer
	  remove_column :filters, :user_id, :integer
	  remove_column :posts, :user_id, :integer
	  remove_column :users_teams, :user_id, :integer
	  add_column :users_groups, :prover_id, :integer
	  add_column :filters, :prover_id, :integer
	  add_column :posts, :prover_id, :integer
	  add_column :users_teams, :prover_id, :integer
	  add_foreign_key :users_groups, :provers, column: :prover_id
	  add_foreign_key :filters, :provers, column: :prover_id
	  add_foreign_key :posts, :provers, column: :prover_id, on_delete: :cascade
	  add_foreign_key :users_teams, :provers, column: :prover_id
  end
end
