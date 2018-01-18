module API
  module V1
    class Users < Grape::API
      helpers do
        def user
          User.find_by(email: params[:email])
        end
      end

      resources :users do
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

          'ok'
        end
      end
    end
  end
end
