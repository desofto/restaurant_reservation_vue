# frozen_string_literal: true

class Schedule < ApplicationRecord
  class Entity < Base
    expose :day do |schedule|
      schedule.date.day
    end

    expose :free_seats, if: ->(_, opt) { !(opt[:user]&.admin? || opt[:user]&.operator?) }

    expose :date, :count, :free_seats,
      if: ->(_, opt) { opt[:user]&.admin? || opt[:user]&.operator? }
  end

  self.table_name = 'schedule'

  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations

  validates :date, presence: true, uniqueness: true
  validates :count, presence: true

  def reserved_seats
    reservations.paid.map(&:guests).sum
  end

  def free_seats
    count - reserved_seats
  end
end
