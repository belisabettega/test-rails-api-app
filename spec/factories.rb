FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      password { Faker::Internet.password }
    end
    factory :restaurant do
      name { Faker::Name.name}
      address { Faker::Address.full_address }
      association :user
    end
end