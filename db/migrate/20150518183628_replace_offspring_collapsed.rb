class ReplaceOffspringCollapsed < ActiveRecord::Migration
  def change
		remove_column :provers, :offspring_collapsed, :boolean
		add_column :provers, :offspring_style, :string
  end
end
