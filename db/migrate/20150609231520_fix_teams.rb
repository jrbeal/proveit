class FixTeams < ActiveRecord::Migration
  def change
		remove_column :teams, :prover, :integer
		remove_column :teams, :topic, :integer
		remove_column :teams, :type, :integer
		add_column :teams, :prover_id, :integer
		add_column :teams, :topic_id, :integer
		add_column :teams, :team_type, :string
		add_foreign_key :teams, :provers, column: :prover_id, on_delete: :cascade
		add_foreign_key :teams, :topics, column: :topic_id, on_delete: :cascade
  end
end
