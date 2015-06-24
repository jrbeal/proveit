class AddProveridToProvers < ActiveRecord::Migration
  def change
	  add_column :topics, :prover_id, :integer
	  add_foreign_key :topics, :provers, column: :prover_id, on_delete: :cascade
  end
end
