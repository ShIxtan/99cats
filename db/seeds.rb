# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.create!(birth_date: Date.new(2012, 1,1) , color: "orange", name: "Markov", sex: "M")
Cat.create!(birth_date: Date.new(2010, 3, 5) , color: "tabby", name: "Tesla", sex: "M" , description: "awesome")
Cat.create!(birth_date: Date.new(2001, 9, 11) , color: "black", name: "Curie", sex: "F", description: "sad")
