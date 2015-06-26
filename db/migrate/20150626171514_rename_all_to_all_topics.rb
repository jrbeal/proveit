class RenameAllToAllTopics < ActiveRecord::Migration
  def change
		remove_column :filters, :all, :boolean
		add_column :filters, :all_topics, :boolean
  end
end
