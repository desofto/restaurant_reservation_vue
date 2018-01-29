# frozen_string_literal: true

module API
  module V1
    class Root < Grape::API
      include API::Auth
      include API::Exceptions

      helpers do
        def declared_params
          declared(params, include_missing: false)
        end

        def current_user
          token = params[:token]
          token.presence && User.find_by(token: token)
        end

        def authorize!(*args)
          raise CanCan::AccessDenied unless current_user.present?
          ::Ability::Factory.build_ability_for(current_user).authorize!(*args)
        end
      end

      before do
        raise CanCan::AccessDenied unless verified_request?
      end

      version 'v1', using: :path
      format :json

      mount API::V1::Ping
      mount API::V1::Schedule
      mount API::V1::Reservations
      mount API::V1::Users
    end
  end
end
