class ModifyFilterColumns < ActiveRecord::Migration
  def change
		remove_column :filters, :public, :boolean
		remove_column :filters, :topics, :boolean
		remove_column :filters, :active, :boolean
		remove_column :filters, :contested_opinions, :boolean
		remove_column :filters, :uncontested_opinions, :boolean
		remove_column :filters, :contested_objections, :boolean
		remove_column :filters, :uncontested_objections, :boolean
		remove_column :filters, :comments, :boolean
		remove_column :filters, :initiators, :boolean
		remove_column :filters, :following, :boolean
		remove_column :filters, :bookmarks, :boolean
		remove_column :filters, :hot_topics, :boolean
		remove_column :filters, :categories, :boolean
		remove_column :filters, :key_words, :boolean
		remove_column :filters, :levels, :boolean
		remove_column :filters, :range, :boolean
		remove_column :filters, :today, :boolean
		remove_column :filters, :last_week, :boolean
		remove_column :filters, :last_month, :boolean
		remove_column :filters, :defaultfilter, :boolean

		add_column :filters, :sitedefault, :boolean
		add_column :filters, :opinions, :boolean
		add_column :filters, :contested, :boolean
		add_column :filters, :uncontested, :boolean
		add_column :filters, :initiators, :boolean
		add_column :filters, :comments, :boolean
		add_column :filters, :following, :boolean
		add_column :filters, :bookmarks, :boolean
		add_column :filters, :level_zero, :boolean
		add_column :filters, :level_nonzero, :boolean
		add_column :filters, :today, :boolean
		add_column :filters, :last_week, :boolean
		add_column :filters, :last_month, :boolean
		add_column :filters, :private, :boolean
		add_column :filters, :public_viewing, :boolean
		add_column :filters, :public_comments, :boolean
		add_column :filters, :sort_by_date, :boolean
		add_column :filters, :sort_by_votes, :boolean
		add_column :filters, :sort_by_views, :boolean
  end
end
