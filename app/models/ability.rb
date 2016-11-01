class Ability
  include CanCan::Ability
    # cancancan will automatically instantiate an ability object with every
    # request. It will just expect you have a method in your controller called
    # current_user
  def initialize(user)
    # it's highly recommended that you start with this line because user will
    # be nil if user is not signed in so it would be nice to have a user
    # variable point to a new User object if it's nil so we can easily compare
    user ||= User.new

    # manage refers to doing any action on the question object: : read, :delete,
    # :edit, :update etc.
    # if you want to be more specific, can define individual actions
    # can :edit, Question do

    can :manage, Question do |q|
      q.user == user
    end

    cannot :like, Question do |q|
      q.user == user
    end

    can :like, Question do |q|
      q.user != user
    end

    can :delete, Answer do |a|
      a.user == user || a.question.user == user
    end

    if user.admin?
      can :manage, :all
    else
      can :read, :all
    end


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
