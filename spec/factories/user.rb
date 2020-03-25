FactoryBot.define do
    factory :user do
        name { "John" }
        email    { Faker::Internet.email }
        password { Faker::Internet.password }
    end
end
