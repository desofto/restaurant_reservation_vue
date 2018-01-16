# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    sequence(:date) { |n| Time.zone.today + n.days }
    count 10
  end
end
