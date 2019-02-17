# frozen_string_literal: true

FactoryBot.define do
  factory :booking do
    name { "#{Faker::Name.last_name}, #{Faker::Name.first_name} (Test Package)" }
    start_time { Date.current + 10.days }
    association :client
    association :booking_package
  end
end
