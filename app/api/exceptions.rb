# frozen_string_literal: true
module API
  module Exceptions
    class AuthenticationError < StandardError; end

    def self.included(base)
      base.rescue_from AuthenticationError do |e|
        message = e.message == e.class.name ? 'Wrong email or password' : e.message
        error!({ errors: message }, 401, 'Content-Type' => 'text/json')
      end

      base.rescue_from ActiveRecord::RecordNotFound do |_e|
        error!({ errors: e.message }, 404 , { 'Content-Type' => 'text/json' })
      end

      base.rescue_from ActiveRecord::RecordInvalid do |e|
        error!({ errors: e.record.errors.messages }, 422, 'Content-Type' => 'text/json')
      end

      base.rescue_from ArgumentError do |e|
        error!({ errors: e.message }, 422, 'Content-Type' => 'text/json')
      end

      base.rescue_from CanCan::AccessDenied do
        error!({ errors: 'You are not authorized to access' }, 422, 'Content-Type' => 'text/json')
      end
    end
  end
end
