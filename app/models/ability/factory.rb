module Ability
  class Factory
    def self.build_ability_for(user)
      case user&.role.to_s
      when 'admin'    then Ability::Admin.new(user)
      when 'operator' then Ability::Operator.new(user)
      when 'client'   then Ability::Client.new(user)
      else raise NotImplementedError
      end
    end
  end
end
