class ReservationsChannel < ApplicationCable::Channel
  def subscribed
    queue = 'reservations_channel'
    stream_from queue, coder: ActiveSupport::JSON do |_|
      next unless ability.can? :index, Reservation
      transmit 'changed', via: queue
    end
  end

  def unsubscribed
    stop_all_streams
  end
end
