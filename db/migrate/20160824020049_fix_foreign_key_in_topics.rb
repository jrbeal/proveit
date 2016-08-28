class FixForeignKeyInTopics < ActiveRecord::Migration
  def change
		remove_foreign_key :topics, column: :root_id
		add_foreign_key :topics, :posts, column: :root_id, on_delete: :cascade
  end
end
