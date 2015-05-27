class ChangeColumnsToNotNil < ActiveRecord::Migration
  def change
		change_column :follows, :follows, :integer, :null => false
		change_column :follows, :owner, :integer, :null => false
  end
end
