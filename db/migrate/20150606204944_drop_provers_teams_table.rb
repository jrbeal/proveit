class DropProversTeamsTable < ActiveRecord::Migration
  def change
	  drop_table :provers_teams
  end
end
