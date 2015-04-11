class RemoveTopicIdFromTeams < ActiveRecord::Migration
  def change
		remove_column :teams, :topic_id, :integer
	end
end
