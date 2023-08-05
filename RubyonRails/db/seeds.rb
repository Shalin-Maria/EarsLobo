# db/seeds.rb

keys = []
keys << Key.create!(code: 'key1', used: false)
keys << Key.create!(code: 'key2', used: false)
keys << Key.create!(code: 'key3', used: false)


puts "keys: #{keys.inspect}"

tenants = []
tenants << Tenant.find_or_create_by!(subdomain: 'tenant1')
tenants << Tenant.find_or_create_by!(subdomain: 'tenant2')

puts "tenant: #{tenants.inspect}"



ActsAsTenant.with_tenant(tenants.first) do

  user = User.create!(
    email: "globalmod@gmail.com",
    password: "password",
    fname: "Global",
    lname:"Mod",
    role: :global_moderator,
    registration_key: keys.third.code,
  )
  user = User.create!(
    email: "testa@gmail.com",
    password: "password",
    fname: "local",
    lname:"Mod",
    role: :local_moderator,
    registration_key: keys.first.code,
  )

  puts "user: #{user.inspect}"

    
    client = Client.create!(
    first_name: 'Client1',
    last_name: 'Test',
    gender: 'Male',
    email: 'client1@test.com',
    date_of_birth: 30.years.ago,
    address1: '123 Street',
    country: 'US',
    state: 'NY',
    city: 'New York',
    zip: '10001',
    phone1: '1234567890'
  )
  
  puts "client: #{client.inspect}"

  
  EmergencyContact.create!(
    first_name: 'Contact1',
    last_name: 'Test',
    phone_number: '1234567890',
    address: '123 Street',
    email: 'contact1@test.com',
    city: 'New York',
    state: 'NY',
    client: client
  )
  Test.create!(
    client_name: 'Client1 Test',
    test_type: 'Type1',
    client: client,
    user: user
  )
end


ActsAsTenant.with_tenant(tenants.second) do

  user = User.create!(
    email: "globalmod12312@gmail.com",
    password: "password",
    fname: "Globaler",
    lname:"Modda",
    role: :global_moderator,
    registration_key: keys.second.code,
  )


    
    client = Client.create!(
    first_name: 'Client1',
    last_name: 'Test',
    email: 'client12@test.com',
    gender: 'Male',
    date_of_birth: 30.years.ago,
    address1: '123 Street',
    country: 'US',
    state: 'NY',
    city: 'New York',
    zip: '10001',
    phone1: '1234567890'
  )
  
  puts "client: #{client.inspect}"

  
  EmergencyContact.create!(
    first_name: 'Coasdasdasntact1',
    last_name: 'Test',
    phone_number: '1234567890',
    address: '123 Street',
    email: 'contact1@test.com',
    city: 'New York',
    state: 'NY',
    client: client
  )
  Test.create!(
    client_name: 'Client1 Test',
    test_type: 'Type1',
    client: client,
    user: user
  )
end


# user = User.create!(
#   email: "globalmod1@gmail.com",
#   password: "password",
#   fname: "Global1",
#   lname:"Mod1",
#   role: :global_moderator,
#   registration_key: keys.second.code
# )
# user.validate_registration_key
# puts "user: #{user.inspect}"
# puts "keys: #{keys.inspect}"
# ActsAsTenant.with_tenant(user.tenant) do
  
#   client = Client.create!(
#     first_name: 'Client1',
#     last_name: 'Test',
#     email: 'client11@test.com',
#     date_of_birth: 30.years.ago,
#     address1: '123 Street',
#     country: 'US',
#     state: 'NY',
#     city: 'New York',
#     zip: '10001',
#     phone1: '1234567890'
#   )
#   puts "client: #{client.inspect}"
  
#   EmergencyContact.create!(
#     first_name: 'Contact11',
#     last_name: 'Test',
#     phone_number: '1234567890',
#     address: '123 Street',
#     email: 'contact1@test.com',
#     city: 'New York',
#     state: 'NY',
#     client: client
#   )
#   Test.create!(
#     client_name: 'Client1 Test',
#     test_type: 'Type1',
#     client: client,
#     user: user
#   )
