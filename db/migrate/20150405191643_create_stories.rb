class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
			t.string :url
			t.string :headline
			t.integer :upvotes
    end
  end
end
