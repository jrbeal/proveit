# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

DECAY_FACTOR = 'decay_factor'
HALF_LIFE_52 = 0.98675869426		# 52 week half life
HALF_LIFE_26 = 0.97369272069		# 26 week half life
HALF_LIFE_13 = 0.94807751434		# 13 week half life
HALF_LIFE_4 = 0.84089641525		# 4 week half life
HALF_LIFE_1 = 0.50000000000		# 1 week half life

Siteconfig.create(:name => DECAY_FACTOR, :floatvalue => HALF_LIFE_26) unless Siteconfig.find_by :name => DECAY_FACTOR

Filter.create(:name => "All", :sitedefault => true, :opinions => true, :has_no_parent => true, :level_zero => true)
