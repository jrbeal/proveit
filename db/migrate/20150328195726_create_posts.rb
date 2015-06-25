class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|

      t.timestamp :activityDate, :null => false
      t.timestamps null: false
		end
  end
end
