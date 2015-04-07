class AddChildrenToPosts < ActiveRecord::Migration
  def change
		add_column :posts, :children, :integer
		add_column :posts, :offspring, :integer
		add_column :posts, :points, :integer
  end
end
