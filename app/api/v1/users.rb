module API
  module V1
    class Users < Grape::API
      helpers do
        def user
          ::User.find_by(email: params[:email])
        end
      end

      resources :users do
        get do
          authorize! :index, ::User

          present User.where(role: %i[admin operator])
        end

        desc 'Authenticate the user'
        params do
          requires :email, type: String
          requires :password, type: String
        end
        post do
          raise API::Exceptions::AuthenticationError unless user&.authenticate(params[:password])
          user.regenerate_token

          present user
        end

        desc 'Logout user'
        get :logout do
          current_user.regenerate_token

          :ok
        end

        route_param :id do
          helpers do
            def user
              ::User.find(params[:id])
            end
          end

          desc 'Delete user'
          params do
            requires :id, type: Integer
          end
          delete do
            authorize! :destroy, ::User

            user.destroy!

            :ok
          end
        end
      end
    end
  end
end
