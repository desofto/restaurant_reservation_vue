# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@gmail.com" }
    password 'SomePass123'

    sequence(:name) { |n| "guest-#{n}" }
    phone '+1234567890'
  end
end
