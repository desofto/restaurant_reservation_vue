# frozen_string_literal: true
module API
  module V1
    module Entities
      class Schedule < Base
        expose :day do |schedule|
          schedule.date.day
        end

        expose :date, if: ->(_, opt) { opt[:user].admin? || opt[:user].operator? }

        expose :count, if: ->(_, opt) { opt[:user].client? } do |schedule|
          schedule.free_seats
        end

        expose :count, if: ->(_, opt) { opt[:user].admin? || opt[:user].operator? }

        expose :free_seats, if: ->(_, opt) { opt[:user].admin? || opt[:user].operator? }
      end
    end
  end
end
