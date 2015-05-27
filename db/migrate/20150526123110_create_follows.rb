class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :owner
      t.integer :follows
    end
		add_foreign_key :follows, :provers, column: :owner, on_delete: :cascade
		add_foreign_key :follows, :provers, column: :follows, on_delete: :cascade
  end
end
