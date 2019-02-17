# frozen_string_literal: true

FactoryBot.define do
  factory :package do
    name { 'Test Package' }
    duration { 90 }
    retainer_fee { 25.00 }
    total_cost { 50.00 }
    description { 'This is a test description.' }
    association :package_group
  end
end
