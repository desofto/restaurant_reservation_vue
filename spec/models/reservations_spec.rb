# frozen_string_literal: true

require 'rails_helper'

describe Reservation do
  let(:reservation) { build(:reservation) }

  it "stores user's info" do
    user = create(:user, name: 'test user', email: 'test@gmail.com', phone: '+12345')

    reservation = create(:reservation, user: user)

    expect(reservation.email).to eq 'test@gmail.com'
    expect(reservation.phone).to eq '+12345'
    expect(reservation.name).to eq 'test user'

    user.update!(name: 'a', email: 'a', phone: 'a')

    expect(reservation.email).to eq 'test@gmail.com'
    expect(reservation.phone).to eq '+12345'
    expect(reservation.name).to eq 'test user'
  end

  it 'validates guests count against number of free seats' do
    schedule = create(:schedule, count: 5)
    create(:reservation, schedule: schedule, guests: 4, status: 'paid')
    schedule.reload

    reservation = build(:reservation, schedule: schedule, guests: 2)

    expect(reservation).not_to be_valid
    expect(reservation.errors[:guests]).not_to be_empty
  end
end
