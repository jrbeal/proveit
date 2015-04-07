class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :team_type
      t.integer :topic_id
      t.integer :account_id
    end
  end
end
