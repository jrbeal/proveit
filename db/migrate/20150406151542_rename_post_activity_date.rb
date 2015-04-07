class RenamePostActivityDate < ActiveRecord::Migration
  def change
		remove_column :posts, :activityDate, :timestamp
		add_column :posts, :activity_at, :timestamp
	end
end
