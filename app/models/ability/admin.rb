module Ability
  class Admin < Ability::Base
    def permissions
      can :manage,  :all
    end
  end
end
