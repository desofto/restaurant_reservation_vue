# frozen_string_literal: true
module API
  module V1
    module Entities
      class Reservation < Base
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
    end
  end
end
