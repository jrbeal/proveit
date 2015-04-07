class AddForeignKeys5 < ActiveRecord::Migration
  def change
    add_foreign_key :topics, :posts, column: :root
  end
end
