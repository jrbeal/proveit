class ReplaceTopicsWithHasParentInFilters < ActiveRecord::Migration
  def change
		remove_column :filters, :topics, :boolean
		add_column :filters, :has_parent, :boolean
  end
end
