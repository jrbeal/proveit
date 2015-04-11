class RenameTeamType2 < ActiveRecord::Migration
  def change
		remove_column :teams, :type, :string
		add_column :teams, :kind, :string
	end
end
