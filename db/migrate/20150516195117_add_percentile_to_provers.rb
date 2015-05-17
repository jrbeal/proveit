class AddPercentileToProvers < ActiveRecord::Migration
  def change
    add_column :provers, :percentile, :float
  end
end
