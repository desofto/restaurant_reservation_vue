# frozen_string_literal: true

class Reservation < ApplicationRecord
  class Entity < Base
    expose :user_id

    expose :date do |reservation|
      {
        year: reservation.schedule.date.year,
        month: reservation.schedule.date.month,
        day: reservation.schedule.date.day,
        hour: reservation.hour
      }
    end

    expose :guests

    expose :name
    expose :phone
    expose :email

    expose :status
  end

  serialize :data, Hash
  store_accessor :data, :hour, :guests, :name, :phone, :email

  belongs_to :user
  belongs_to :schedule

  validates :user, presence: true
  validates :schedule, presence: true

  validates :hour, presence: true
  validates :guests, presence: true

  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true

  enum status: %i[placed paid rejected]

  before_validation :prefill_user_info

  validate :check_for_enought_seats_on_schedule

  after_commit :broadcast

  private

  def broadcast
    ActionCable.server.broadcast 'reservations_channel', 'changed'
  end

  def check_for_enought_seats_on_schedule
    return if guests <= schedule.free_seats

    errors.add(:guests, 'There is no enough seats on this date')
  end

  def prefill_user_info
    self.name ||= user&.name
    self.phone ||= user&.phone
    self.email ||= user&.email
  end
end
