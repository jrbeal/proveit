class ConvertUserTeamsToBoolean < ActiveRecord::Migration
  def change
		remove_column :topics, :use_teams, :integer
		add_column :topics, :use_teams, :boolean
  end
end
