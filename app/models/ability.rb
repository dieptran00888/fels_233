class Ability
  include CanCan::Ability

  def initialize user
    if user.is_admin?
      can :manage, Category
    else
      can :update, User
    end
  end
end
