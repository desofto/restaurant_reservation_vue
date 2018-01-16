# frozen_string_literal: true

class Schedule < ApplicationRecord
  self.table_name = 'schedule'

  has_many :reservations
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
