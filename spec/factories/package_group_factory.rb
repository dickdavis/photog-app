# frozen_string_literal: true

FactoryBot.define do
  factory :package_group do
    name { 'Test Package Group' }
    description { 'This is a test description.' }
  end
end
