# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

prover = Prover.find_by(email: 'jrbeal@cox.net')
prover.update(administrator: true)
Filter.new(name: 'Topics', default: true, topics: true).save
Filter.new(name: 'Opinions', default: true, contested_opinions: true, uncontested_opinions: true).save
Filter.new(name: 'Objections', default: true, contested_objections: true, uncontested_objections: true).save
Filter.new(name: 'Initiators', default: true, initiators: true).save
Filter.new(name: 'Comments', default: true, comments: true).save
Filter.new(name: 'Following', default: true, following: true).save
Filter.new(name: 'Bookmarks', default: true, bookmarks: true).save
