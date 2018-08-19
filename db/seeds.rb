# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'


isaac_admin = User.create!(
  email: 'isorme1@gmail.com',
  password: '123123',
  subscription: true,
  role: 'admin'
)

isaac_member = User.create!(
  email: 'iorme1.test@gmail.com',
  password: '123123',
  subscription: true
)

users = User.all

5.times do
  isaac_admin.posts.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraphs(3)
  )
end

posts = Post.all

20.times do
  Comment.create!(
    body: Faker::Lorem.sentence,
    user: users.sample,
    post: posts.sample
  )
end

puts "Seeds finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
