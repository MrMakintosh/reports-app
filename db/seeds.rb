# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(email: 'chaplin1488@gmail.com', password: 'gbxtymrf88vfrbynji', admin: 1, name: 'Alexander', surname: 'Buyanov')
User.create(email: 'usertest@test.com', password: 'test88test')