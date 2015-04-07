class AddChildToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :child, :integer
  end
end
