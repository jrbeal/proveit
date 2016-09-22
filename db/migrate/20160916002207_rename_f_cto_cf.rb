class RenameFCtoCf < ActiveRecord::Migration
  def self.up
		rename_table :filter_categories, :categories_filters
  end
  def self.down
		rename_table :categories_filters, :filter_categories
  end
end
