class RenameTeamsInTopics < ActiveRecord::Migration
  def change
		remove_column :topics, :teams, :integer
		add_column :topics, :use_teams, :integer
  end
end
