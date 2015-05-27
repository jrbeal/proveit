class AddRankingToProvers < ActiveRecord::Migration
  def change
		add_column :provers, :ranking, :float
  end
end
