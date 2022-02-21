FactoryBot.define do
  factory :customer do
    transient do
      person { Gimei.name }
    end
    first_name { person.first.kanji }
    last_name { person.last.kanji }
    first_name_kana { person.first.katakana }
    last_name_kana { person.last.katakana }
    tel { "01234567890" }
    address {"熊本県熊本市一丁目"}
    email         { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end