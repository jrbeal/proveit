class AddChannelScoreToTopic < ActiveRecord::Migration
  def change
		add_column :topics, :channel_score, :float
  end
end
