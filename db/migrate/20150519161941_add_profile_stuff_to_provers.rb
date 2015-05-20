class AddProfileStuffToProvers < ActiveRecord::Migration
  def change
	    add_column :provers, :aboutme, :text
	    add_column :provers, :education, :string
	    add_column :provers, :occupation, :string
	    add_column :provers, :location, :string
  end
end
