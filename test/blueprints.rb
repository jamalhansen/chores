require 'machinist/active_record'
require 'sham'
require 'faker'

Chore.blueprint do
  description "Put the dirty clothes in the hamper"
end

Identity.blueprint do
  identifier "http://#{Faker::Name.first_name}.#{Faker::Internet.domain_name}/"
end

Child.blueprint do
  child { Identity.make }
  parent { Identity.make }
end
