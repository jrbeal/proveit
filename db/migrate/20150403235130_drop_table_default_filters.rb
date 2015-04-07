class DropTableDefaultFilters < ActiveRecord::Migration
  def up
		drop_table :default_filters
  end

	def down
		raise ActiveRecord::IrreversibleMigration
	end
end
