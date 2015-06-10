class RenameTeamsColumns < ActiveRecord::Migration
  def change
		remove_column :teams, :provers, :integer
		remove_column :teams, :topics, :integer
		add_column :teams, :prover, :integer
		add_column :teams, :topic, :integer
		add_foreign_key :teams, :provers, column: :prover, on_delete: :cascade
		add_foreign_key :teams, :topics, column: :topic, on_delete: :cascade
  end
end
