class CreateNewTeams < ActiveRecord::Migration
  def change
	    create_table :teams do |t|
			  t.integer :provers
				t.integer :topics
				t.string :type
			end
			add_foreign_key :teams, :provers, column: :provers, on_delete: :cascade
			add_foreign_key :teams, :topics, column: :topics, on_delete: :cascade
  end
end
