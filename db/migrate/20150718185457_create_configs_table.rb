class CreateConfigsTable < ActiveRecord::Migration
  def change
    create_table :configs_tables do |t|
		  t.string :name
		  t.string :stringvalue
		  t.integer :integervalue
		  t.float :floatvalue
    end
  end
end
