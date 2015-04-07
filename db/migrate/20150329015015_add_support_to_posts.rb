class AddSupportToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :support, :text
  end
end
