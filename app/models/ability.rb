class Ability
  include CanCan::Ability

  def initialize user
    if user.is_admin?
      can :manage, [Category, Word]
    else
      can :update, User
      can :show, Category
      can [:create, :update, :show], Lesson
    end
  end
end
