class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :user_id
      t.integer :topic_id
      t.string :group_name

      t.timestamps null: false
    end
  end
end
