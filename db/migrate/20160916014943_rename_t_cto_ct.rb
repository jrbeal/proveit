class RenameTCtoCt < ActiveRecord::Migration
  def self.up
	  rename_table :topic_categories, :categories_topics
  end
  def self.down
    rename_table :categories_topics, :topic_categories
  end
end
