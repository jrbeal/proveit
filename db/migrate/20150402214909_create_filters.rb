class CreateFilters < ActiveRecord::Migration
  def change
    create_table :filters do |t|
      t.string :name
      t.boolean :contested_opinions
      t.boolean :uncontested_opinions
      t.boolean :contested_objections
      t.boolean :uncontested_objections
      t.boolean :comments
      t.boolean :initiators
      t.boolean :following
      t.boolean :active
      t.boolean :bookmarks
      t.boolean :hot_topics
      t.boolean :categories
      t.boolean :key_words
      t.boolean :levels
      t.boolean :range
      t.boolean :today
      t.boolean :last_week
      t.boolean :last_month

      t.timestamps null: false
    end
  end
end
