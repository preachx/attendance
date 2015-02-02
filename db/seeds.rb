# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

Event.create!(event_date: "2015-02-04", description: "Event1")
Event.create!(event_date: "2015-02-05", description: "Event2")
Event.create!(event_date: "2015-02-06", description: "Event3")
