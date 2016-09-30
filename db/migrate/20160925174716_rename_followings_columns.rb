class RenameFollowingsColumns < ActiveRecord::Migration
  def change
		remove_column :followings, :follower_id, :integer
		remove_column :followings, :followee_id, :integer
		add_column :followings, :prover_id, :integer
		add_column :followings, :following_id, :integer
  end
end
