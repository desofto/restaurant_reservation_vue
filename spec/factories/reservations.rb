# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    user

    schedule { find_or_create(:schedule, date: Time.zone.today, count: 10) }
    hour { (1..12).to_a.sample }
    guests { (1..10).to_a.sample }

    status :placed
  end
end
