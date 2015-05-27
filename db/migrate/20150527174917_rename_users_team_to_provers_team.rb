class RenameUsersTeamToProversTeam < ActiveRecord::Migration
  def change
		drop_table :users_teams
		create_table :provers_teams do |t|
			t.integer :team_id
			t.integer :prover_id
		end
		add_foreign_key :provers_teams, :provers
		add_foreign_key :provers_teams, :teams
  end
end
