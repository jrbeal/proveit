class CreateHotTopics < ActiveRecord::Migration
  def change
    create_table :hot_topics do |t|
			t.string :key_phrase
			t.integer :count
    end
  end
end
