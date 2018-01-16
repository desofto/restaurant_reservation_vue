# frozen_string_literal: true

require 'rails_helper'

describe Schedule do
  let(:schedule) { build(:schedule) }

  it 'group users' do
    user1 = create(:user)
    user2 = create(:user)

    create(:reservation, schedule: schedule, user: user1)
    create(:reservation, schedule: schedule, user: user2)

    expect(schedule.users.count).to eq 2
    expect(schedule.user_ids).to match_array [user1.id, user2.id]
  end

  context 'validators' do
    it 'validates date for uniqueness' do
      create(:schedule, date: Time.zone.today)

      schedule = build(:schedule, date: Time.zone.today)

      expect(schedule).not_to be_valid
      expect(schedule.errors[:date]).not_to be_empty
    end
  end
end
