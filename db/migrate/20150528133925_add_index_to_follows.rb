class AddIndexToFollows < ActiveRecord::Migration
  def change
		add_index "follows", ["owner", "follows"], :unique => true
  end
end
