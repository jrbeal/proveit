class AddForeignKeys < ActiveRecord::Migration
  def change
    add_column :filters, :user_id, :integer
		add_foreign_key :filters, :users
  end
end
