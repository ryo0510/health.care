FactoryBot.define do
  factory :course do
    name { Faker::Lorem.characters(number: 5) }
    working_item { Faker::Lorem.characters(number: 30) }
    target_date Faker::Number.between(from: 1, to: 120)
    way { 'number' }
  end
end