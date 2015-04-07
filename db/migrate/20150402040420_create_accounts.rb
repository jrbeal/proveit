class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :user_name
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :timezone
      t.string :language
      t.binary :password
      t.integer :verbosity
      t.integer :default_filter
      t.boolean :list
      t.string :location
      t.string :occupation
      t.string :phone
      t.string :education
      t.string :about
      t.integer :opinions
      t.integer :comments
      t.integer :initiators
      t.integer :offspring
      t.float :rating
      t.float :percentile

      t.timestamps null: false
    end
  end
end
