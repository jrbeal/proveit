# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Filter.delete_all
Filter.new(name: 'Topics', sitedefault: true, topics: true, level_zero: true).save
Filter.new(name: 'Opinions', sitedefault: true, opinions: true, level_zero: true).save
Filter.new(name: 'Objections', sitedefault: true, opinions: true, level_nonzero: true).save
Filter.new(name: 'Initiators', sitedefault: true, initiators: true, level_zero: true).save
Filter.new(name: 'Comments', sitedefault: true, comments: true, level_zero: true).save
Filter.new(name: 'Following', sitedefault: true, following: true).save
Filter.new(name: 'Bookmarks', sitedefault: true, bookmarks: true).save
Filter.new(name: 'MyTopics', sitedefault: false, topics: true, level_zero: true).save
Filter.new(name: 'MyOpinions', sitedefault: false, opinions: true, level_zero: true).save
Filter.new(name: 'MyObjections', sitedefault: false, opinions: true, level_nonzero: true).save
Filter.new(name: 'MyContestedOpinions', sitedefault: false, opinions: true, level_zero: true, contested: true).save
Filter.new(name: 'MyContestedObjections', sitedefault: false, opinions: true, level_nonzero: true, contested: true).save
Filter.new(name: 'MyInitiators', sitedefault: false, initiators: true, level_zero: true).save
Filter.new(name: 'MyComments', sitedefault: false, comments: true, level_zero: true).save
prover = Prover.find_by(email: 'jrbeal@cox.net')
prover.update(administrator: true)
