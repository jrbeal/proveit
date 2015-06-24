class AddTopicsToFiltersAgain < ActiveRecord::Migration
  def change
	  add_column :filters, :topics, :boolean
  end
end
