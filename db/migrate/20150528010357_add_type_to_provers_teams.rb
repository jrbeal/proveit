class AddTypeToProversTeams < ActiveRecord::Migration
  def change
		add_column :provers_teams, :type, :string
  end
end
