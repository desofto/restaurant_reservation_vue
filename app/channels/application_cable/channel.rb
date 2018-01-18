module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def current_user
      token = params[:token]
      token && User.find_by(token: token)
    end

    def ability
      user = current_user
      raise CanCan::AccessDenied unless user.present?
      Ability::Factory.build_ability_for(user)
    end
  end
end
