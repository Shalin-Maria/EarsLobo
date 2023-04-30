# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

load(Rails.root.join('db', 'seeds', 'clients_seed.rb'))
# db/seeds.rb

# Generate Users
5.times do
    User.create!(
      email: Faker::Internet.unique.email,
      password: 'password123',
      password_confirmation: 'password123',
      fname: Faker::Name.first_name,
      lname: Faker::Name.last_name
    )
  end
  
  users = User.all
    
  clients = Client.all
  
  # Generate Tests
  3.times do
    Test.create!(
      user: users.sample,
      client: clients.sample,
      client_name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
      ear_advantage: %w[Left Right].sample,
      ear_advantage_score: rand(1.0..10.0).round(2),
      label: Faker::Lorem.word,
      left_score: rand(1.0..10.0).round(2),
      notes: Faker::Lorem.sentence,
      right_score: rand(1.0..10.0).round(2),
      test_type: %w[DWT RDT].sample
    )
  end
  