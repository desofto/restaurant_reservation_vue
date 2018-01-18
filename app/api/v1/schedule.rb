module API
  module V1
    class Schedule < Grape::API
      helpers do
        def year
          params[:year]
        end

        def month
          params[:month]
        end

        def schedule(year, month)
          date = DateTime.new(year, month, 1)
          ::Schedule.where('date BETWEEN ? AND ?', date.beginning_of_month, date.end_of_month)
        end
      end

      resources :schedule do
        desc 'Returns schedule for month'
        params do
          requires :year, type: Integer
          requires :month, type: Integer
        end
        get '/:year/:month' do
          present schedule(year, month)
        end

        desc 'Returns schedule for admin'
        get do
          authorize! :index, ::Schedule

          present ::Schedule.all, user: current_user
        end
      end
    end
  end
end
