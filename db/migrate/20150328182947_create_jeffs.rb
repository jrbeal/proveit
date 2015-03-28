class CreateJeffs < ActiveRecord::Migration
  def change
    create_table :jeffs do |t|

      t.timestamps null: false
    end
  end
end
