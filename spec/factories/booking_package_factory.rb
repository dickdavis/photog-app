# frozen_string_literal: true

FactoryBot.define do
  factory :booking_package do
    name { 'Test Package' }
    duration { 90 }
    retainer_fee { 25.00 }
    total_cost { 50.00 }
  end
end
