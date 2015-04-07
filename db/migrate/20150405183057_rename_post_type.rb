class RenamePostType < ActiveRecord::Migration
  def self.up
		rename_column :posts, :post_type, :type
  end

  def self.up
  end
end
