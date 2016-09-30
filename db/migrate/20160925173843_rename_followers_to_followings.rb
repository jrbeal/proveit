class RenameFollowersToFollowings < ActiveRecord::Migration
  def self.up
		rename_table :followers, :followings
  end
  def self.down
		rename_table :followings, :followers
  end
end
