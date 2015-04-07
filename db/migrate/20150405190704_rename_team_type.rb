class RenameTeamType < ActiveRecord::Migration
  def change
		remove_column :teams, :team_type, :string
		add_column :teams, :type, :string
  end
end
