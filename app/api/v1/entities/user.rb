# frozen_string_literal: true
module API
  module V1
    module Entities
      class User < Base
        expose :email
        expose :role
        expose :token
      end
    end
  end
end
