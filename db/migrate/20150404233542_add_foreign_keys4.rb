class AddForeignKeys4 < ActiveRecord::Migration
  def change
		add_column :topics, :team1, :integer
		add_column :topics, :team2, :integer
		add_foreign_key :topics, :teams, column: :team1
		add_foreign_key :topics, :teams, column: :team2
		add_foreign_key :topics, :categories, column: :categories
		add_foreign_key :topics, :posts, column: :root
  end
end
