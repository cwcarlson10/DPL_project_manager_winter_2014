# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


4.times do |n|
  name = "User-#{n+1}"
  email = "example-#{n+1}@devpointlabs.com"
  password = "password"
  User.create!(
    name: name,
    email: email,
    phone_number: '555-555-5555',
    password: password,
    password_confirmation: password
  )
end

Project.create!(
  team: 'The Dodgers',
  title: 'Win the Game',
  description: 'Go out and play hard and win the game by being better then everyone else',
  deadline: 2015-07-30,
  user_id: 3
  )