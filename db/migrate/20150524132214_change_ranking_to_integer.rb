class ChangeRankingToInteger < ActiveRecord::Migration
  def change
	remove_column :provers, :ranking, :float
	add_column :provers, :ranking, :integer
  end
end
