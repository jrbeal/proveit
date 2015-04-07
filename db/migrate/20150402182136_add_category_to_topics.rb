class AddCategoryToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :categories, :integer
  end
end
