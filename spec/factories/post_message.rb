FactoryBot.define do
  factory :post_message do
    nickname { Faker::Lorem.characters(number: 5) }
    message { Faker::Lorem.characters(number: 20) }
  end
end