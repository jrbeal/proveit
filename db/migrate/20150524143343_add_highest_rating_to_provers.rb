class AddHighestRatingToProvers < ActiveRecord::Migration
  def change
		add_column :provers, :highest_rating, :float
  end
end
