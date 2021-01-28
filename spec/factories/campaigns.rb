# spec/factories/todos.rb
FactoryBot.define do
  factory :campaign do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    description {Faker::Lorem.sentence }
    bio {Faker::Lorem.paragraph }
  end
end
