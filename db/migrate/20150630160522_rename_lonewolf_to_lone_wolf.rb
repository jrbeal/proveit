class RenameLonewolfToLoneWolf < ActiveRecord::Migration
  def change
		remove_column :filters, :lonewolf, :boolean
		add_column :filters, :lone_wolf, :boolean
  end
end
