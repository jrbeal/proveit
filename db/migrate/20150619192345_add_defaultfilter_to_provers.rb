class AddDefaultfilterToProvers < ActiveRecord::Migration
  def change
	  add_column :provers, :default_filter, :integer
	  add_foreign_key :provers, :filters, column: :default_filter
  end
end
