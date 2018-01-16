# frozen_string_literal: true
module API
  module V1
    module Entities
      class Schedule < Base
        expose :day do |schedule|
          schedule.date.day
        end

        expose :count do |schedule|
          schedule.free_seats
        end
      end
    end
  end
end
