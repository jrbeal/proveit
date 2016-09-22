class RemoveJoinTables < ActiveRecord::Migration
  def change
		drop_table :categories_filters
		drop_table :categories_topics
  end
end
