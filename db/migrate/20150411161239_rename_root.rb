class RenameRoot < ActiveRecord::Migration
  def change
		remove_column :topics, :root, :integer
		add_column :topics, :root_id, :integer
		remove_column :topics, :team1, :integer
		add_column :topics, :team1_id, :integer
		remove_column :topics, :team2, :integer
		add_column :topics, :team2_id, :integer
		remove_column :topics, :categories, :integer
		add_column :topics, :categories_id, :integer
	end
end
