require 'machinist/active_record'
require 'uuid_generator'

include UuidGenerator

Person.blueprint do
  full_name { 'Jane Smith' }
  account { uuid }
  auth_token { uuid }
end