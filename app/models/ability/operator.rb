module Ability
  class Operator < Ability::Base
    def permissions
      can :index, ::Schedule
      can :index, ::Reservation
      can :index, ::User
    end
  end
end
