FactoryBot.define do
  factory :category do
    result { Faker::Lorem.characters(number: 5) }
    memo { Faker::Lorem.characters(number: 30) }
    start_time { Faker::Date.between(from: 30.days.ago, to: Date.today) }
  end
end