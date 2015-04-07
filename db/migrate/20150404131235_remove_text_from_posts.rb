class RemoveTextFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :text, :string
		add_column :posts, :message, :string
  end
end
