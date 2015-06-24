class RenameCurrentFilterToCurFilter < ActiveRecord::Migration
  def change
		remove_column :provers, :filter, :string
		remove_column :provers, :current_filter, :integer
		add_column :provers, :cur_filter, :integer
		add_foreign_key :provers, :filters, column: :cur_filter
  end
end
