class RemoveFilterProverCascadeDelete < ActiveRecord::Migration
  def change
		remove_foreign_key :filters, :provers
		add_foreign_key :filters, :provers
  end
end
