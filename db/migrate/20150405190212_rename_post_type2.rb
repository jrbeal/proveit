class RenamePostType2 < ActiveRecord::Migration
  def change
		remove_column :posts, :post_type, :string
		add_column :posts, :type, :string
  end
end
