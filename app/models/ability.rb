# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if (user.is_admin)
      can :access, :rails_admin
      can :read, :dashboard
      can :manage, :all
    end
  end
end
