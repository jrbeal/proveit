class CreateSiteconfigsTable < ActiveRecord::Migration
  def change
    create_table :siteconfigs do |t|
		  t.integer :post_id
			t.string :name
			t.string :stringvalue
			t.integer :integervalue
			t.float :floatvalue
    end
  end
end
