# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CONFIG_NAME = 'decay_factor'
HALF_LIFE_52 = 0.98675869426		# 52 week half life
HALF_LIFE_26 = 0.97369272069		# 26 week half life
HALF_LIFE_13 = 0.94807751434		# 13 week half life
HALF_LIFE_4 = 0.84089641525		# 4 week half life
HALF_LIFE_1 = 0.50000000000		# 1 week half life

Siteconfig.create(:name => CONFIG_NAME, :floatvalue => HALF_LIFE_26) unless Siteconfig.find_by :name => CONFIG_NAME

Filter.create(:name => "All", :sitedefault => true, :opinions => true, :level_zero => true)

Category.create(:name => "Animals")
