class RemoveRootFromTopic < ActiveRecord::Migration
  def change
		remove_column :topics, :root_id, :integer
  end
end
