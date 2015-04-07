class RemoveTopicIdFromGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :topic_id, :integer
  end
end
