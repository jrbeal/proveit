class ReplaceProverIdWithCascadeDeletion < ActiveRecord::Migration
  def change
	  remove_column :filters, :prover_id, :integer
	  add_column :filters, :prover_id, :integer
	  add_foreign_key :filters, :provers, column: :prover_id, on_delete: :cascade
  end
end
