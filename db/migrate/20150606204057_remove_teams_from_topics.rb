class RemoveTeamsFromTopics < ActiveRecord::Migration
  def change
		remove_column :topics, :team1_id, :integer
		remove_column :topics, :team2_id, :integer
  end
end
