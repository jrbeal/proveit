class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :topic_id
      t.integer :user_id
      t.string :team
    end
  end
end
