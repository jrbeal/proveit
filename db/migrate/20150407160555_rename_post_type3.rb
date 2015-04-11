class RenamePostType3 < ActiveRecord::Migration
	def change
		remove_column :posts, :type, :string
		add_column :posts, :kind, :string
	end
end
