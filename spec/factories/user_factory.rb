# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    business_name { Faker::Company.name + Faker::Company.suffix }
    brand { Faker::Company.name }
    bio { Faker::Lorem.paragraph }
  end
end
