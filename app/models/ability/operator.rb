module Ability
  class Operator < Ability::Base
    def permissions
      can :index, Reservation
    end
  end
end
