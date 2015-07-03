class RemoveCategoriesFromTopics < ActiveRecord::Migration
  def change
		remove_column :topics, :categories_id, :integer
  end
end
