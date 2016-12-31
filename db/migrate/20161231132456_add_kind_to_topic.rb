class AddKindToTopic < ActiveRecord::Migration
  def change
		add_column :topics, :kind, :string
  end
end
