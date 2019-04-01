# frozen_string_literal: true

FactoryBot.define do
  factory :booking_request do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone_number { Faker::Number.number(10) }
    requested_date { Date.current + 2.days }
    requested_time { Time.now }
    association :package
  end
end
