class CreateTableTopicCategory < ActiveRecord::Migration
  def change
    create_table :topic_categories do |t|
		  t.integer :topic_id
		  t.integer :category_id
    end
			add_foreign_key :topic_categories, :topics, column: :topic_id, on_delete: :cascade
			add_foreign_key :topic_categories, :categories, column: :category_id, on_delete: :cascade
  end
end
