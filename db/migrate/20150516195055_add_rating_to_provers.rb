class AddRatingToProvers < ActiveRecord::Migration
  def change
    add_column :provers, :rating, :float
  end
end
