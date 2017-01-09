class AddSortByScoresToFilters < ActiveRecord::Migration
  def change
		add_column :filters, :sort_by_scores, :boolean
  end
end
