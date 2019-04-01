# frozen_string_literal: true

FactoryBot.define do
  factory :booking do
    name { "#{Faker::Name.last_name}, #{Faker::Name.first_name} (Test Package)" }
    start_date { Date.current + 10.days }
    start_time { Time.now }
    association :client
    association :booking_package
  end
end
