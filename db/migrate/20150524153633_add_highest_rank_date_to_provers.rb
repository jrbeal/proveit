class AddHighestRankDateToProvers < ActiveRecord::Migration
  def change
		add_column :provers, :highest_rating_date, :timestamp
  end
end
