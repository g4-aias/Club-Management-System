# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


####change the validation in user.rb before testing for this

User.create!(firstname: "first",
             lastname: "last",
             name:  "Example User",
             email: "example@sfu.ca",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  firstname = "first #{n+1}"
  lastname = "last #{n+1}"
  name  = Faker::Name.name
  email = "example-#{n+1}@sfu.ca"
  password = "password"
  User.create!(firstname: firstname,
               lastname: lastname,
               name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end