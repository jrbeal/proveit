class AddForeignKeysToTopics < ActiveRecord::Migration
  def change
		add_foreign_key :topics, :posts, column: :root_id
		add_foreign_key :topics, :teams, column: :team1_id
		add_foreign_key :topics, :teams, column: :team2_id
		add_foreign_key :topics, :categories, column: :categories_id
	end
end
