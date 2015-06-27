class RemoveAllTopicsFromFilters < ActiveRecord::Migration
  def change
		remove_column :filters, :all_topics, :boolean
  end
end
