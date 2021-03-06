module API
  module V1
    class Reservations < Grape::API
      helpers do
        def user
          user = ::User.find_by(email: params[:identification][:email])

          if user.present?
            raise API::Exceptions::AuthenticationError unless user.authenticate(params[:identification][:password])
            user.update!(
              name: params[:identification][:name],
              phone: params[:identification][:phone]
            )
          else
            user = User.create(
              role: 'client',
              email: params[:identification][:email],
              password: params[:identification][:password],
              name: params[:identification][:name],
              phone: params[:identification][:phone]
            )
          end

          user
        end

        def schedule
          ::Schedule.find_by(date: date)
        end

        def date
          DateTime.new(params[:reservation][:date][:year], params[:reservation][:date][:month], params[:reservation][:date][:day])
        end
      end

      resources :reservations do
        desc 'Creates a reservation'
        params do
          requires :reservation, type: Hash do
            requires :guests, type: Integer
            requires :date, type: Hash do
              requires :year, type: Integer
              requires :month, type: Integer
              requires :day, type: Integer
              requires :hour, type: Integer
            end
          end
          requires :identification, type: Hash do
            requires :name, type: String
            requires :phone, type: String
            requires :email, type: String
            requires :password, type: String
          end
        end
        post do
          reservation = ::Reservation.create!(
            user: user,
            schedule: schedule,
            hour: params[:reservation][:date][:hour],
            guests: params[:reservation][:guests]
          )

          present reservation
        end

        route_param :id do
          helpers do
            def reservation
              @reservation ||= ::Reservation.find(params[:id])
            end
          end

          desc 'Make payment for reservation'
          params do
            requires :id, type: Integer
            requires :token, type: String
          end
          post '/pay' do
            unless reservation.paid?
              Stripe.api_key = 'sk_test_9ma1cKxI39scThGDobad1rLv'
              charge = Stripe::Charge.create(
                amount: 100,
                currency: 'usd',
                description: "A table for #{reservation.guests} person on #{reservation.schedule.date}",
                source: params[:token],
              )

              reservation.paid! if charge.paid && charge.status == 'succeeded'
            end

            present :ok
          end
        end

        desc 'Get list of reservations'
        params do
        end
        get do
          authorize! :index, ::Reservation

          reservations = Reservation.all

          present reservations
        end
      end
    end
  end
end
