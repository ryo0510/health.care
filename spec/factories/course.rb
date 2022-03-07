FactoryBot.define do
  factory :course do
    name { Faker::Lorem.characters(number: 5) }
    working_item { Faker::Lorem.characters(number: 30) }
    target_date { '85' }
    way { 'number' }
  end
end