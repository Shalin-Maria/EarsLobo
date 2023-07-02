# db/seeds.rb

keys = Key.create!([
  { code: 'key1', used: false },
  { code: 'key2', used: false },
])

puts "keys: #{keys.inspect}"

tenants = Tenant.create!([
  { subdomain: 'tenant1' },
  { subdomain: 'tenant2' },
])
puts "tenant: #{tenants.inspect}"



users = User.create!([
  { email: "globalmod@gmail.com", password: "password", fname: "Global", lname:"Mod", role: :global_moderator, tenant: tenants.first,registration_key: keys.first.code, subdomain: 'subdomain1'},
    
  { email: "localmod@gmail.com", password: "password",fname: "Local", lname:"Mod", role: :local_moderator, tenant: tenants.second,registration_key: keys.second.code, subdomain: 'subdomain2'
  }
])

puts "Users: #{users.inspect}"

clients = Client.create!([
  { 
    first_name: 'Client1',
    last_name: 'Test',
    email: 'client1@test.com',
    date_of_birth: 30.years.ago,
    address1: '123 Street',
    country: 'US',
    state: 'NY',
    city: 'New York',
    zip: '10001',
    phone1: '1234567890',
    tenant: tenants.first 
  },
  { 
    first_name: 'Client2',
    last_name: 'Test',
    email: 'client2@test.com',
    date_of_birth: 35.years.ago,
    address1: '456 Street',
    country: 'US',
    state: 'CA',
    city: 'Los Angeles',
    zip: '90001',
    phone1: '9876543210',
    tenant: tenants.second
  },
])

puts "Clients: #{clients.inspect}"

emergency_contacts = EmergencyContact.create!([
  { 
    first_name: 'Contact1',
    last_name: 'Test',
    phone_number: '1234567890',
    address: '123 Street',
    email: 'contact1@test.com',
    city: 'New York',
    state: 'NY',
    client: clients.first,
    tenant: tenants.first
  },
  { 
    first_name: 'Contact2',
    last_name: 'Test',
    phone_number: '9876543210',
    address: '456 Street',
    email: 'contact2@test.com',
    city: 'Los Angeles',
    state: 'CA',
    client: clients.second,
    tenant: tenants.second
  },
])

puts "Emergency Contacts: #{emergency_contacts.inspect}"

tests = Test.create!([
  {
    client_name: 'Client1 Test',
    test_type: 'Type1',
    client: clients.first,
    tenant: tenants.first,
    user: users.first
  },
  {
    client_name: 'Client2 Test',
    test_type: 'Type2',
    client: clients.second,
    tenant: tenants.second,
    user: users.second
  },
])

puts "Tests: #{tests.inspect}"
