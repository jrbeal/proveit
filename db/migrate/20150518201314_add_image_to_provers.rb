class AddImageToProvers < ActiveRecord::Migration
  def change
	  add_column :provers, :image_url, :string
  end
end
