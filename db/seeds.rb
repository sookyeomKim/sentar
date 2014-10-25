# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User.create!(name:  "Example User",
#              email: "example@railstutorial.org",
#              password:              "foobar",
#              password_confirmation: "foobar",
#              admin: true ,
#              activated: true,
#              activated_at: Time.zone.now)

# 99.times do |n|
#   name  = Faker::Name.name
#   email = "example-#{n+1}@railstutorial.org"
#   password = "password"
#   User.create!(name:  name,
#                email: email,
#                password:              password,
#                password_confirmation: password,
#                activated: true,
#               activated_at: Time.zone.now)
# end



            
            
             
             
           
#  #Microposts
# User.order(:created_at).take(5).each do |user|
#   10.times do
#     user.microposts.create!(title:Faker::Lorem.sentence(5), content: Faker::Lorem.sentence(5))
#   end
# end

# # Following relationships
# users = User.all
# user  = users.first
# following = users[2..50]
# followers = users[3..40]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) }


# Shelter.create!(name:  "ksk",
#              introduce: "test",
#              user_id: 1,
#              lonlat: 223424234)