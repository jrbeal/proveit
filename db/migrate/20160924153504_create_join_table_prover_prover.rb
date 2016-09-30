class CreateJoinTableProverProver < ActiveRecord::Migration
  def change
		create_table :followers, :id => false do |t|
			t.references :follower, :null => false
			t.references :followee, :null => false
	  end
		add_index(:followers, [:follower_id, :followee_id], :unique => true)
  end
end
