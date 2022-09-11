FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      password { Faker::Internet.password }
      authentication_token { Faker::Internet.password(min_length: 8) }
    end
    factory :restaurant do
      name { Faker::Name.name}
      address { Faker::Address.full_address }
      association :user
    end
    factory :comment do
      association :user
      association :restaurant
    end
end