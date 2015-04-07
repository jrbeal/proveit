class AddObjectionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :objections, :integer
  end
end
