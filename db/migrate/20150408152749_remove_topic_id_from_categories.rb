class RemoveTopicIdFromCategories < ActiveRecord::Migration
  def change
		remove_column :categories, :topic_id, :integer
	end
end
