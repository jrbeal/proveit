class RenamePostId < ActiveRecord::Migration
  def change
		remove_column :topics, :post_id, :integer
		add_column :topics, :root, :integer
  end
end
