class CreateJoinTableCategoryTopic < ActiveRecord::Migration
  def change
		create_table :categories_topics, :id => false do |t|
			t.references :category, :null => false
			t.references :topic, :null => false
	  end
		add_index(:categories_topics, [:category_id, :topic_id], :unique => true)
	end
end
