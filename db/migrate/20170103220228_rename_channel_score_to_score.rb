class RenameChannelScoreToScore < ActiveRecord::Migration
  def change
		remove_column :topics, :channel_score, :float
		add_column :topics, :score, :float
  end
end
