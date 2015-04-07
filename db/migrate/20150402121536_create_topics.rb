class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :topic_id
      t.boolean :private
      t.boolean :lone_wolf
      t.boolean :teams
      t.boolean :public_viewing
      t.boolean :public_comments
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
