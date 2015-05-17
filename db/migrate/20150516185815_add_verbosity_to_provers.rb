class AddVerbosityToProvers < ActiveRecord::Migration
  def change
    add_column :provers, :verbosity, :integer
  end
end
