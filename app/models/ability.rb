class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
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
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    # not registered users should only be able to register users...
    can :create, User
    can :index, User
    if user.present?
      can :manage, User do |u|
        u == user
      end
      # Every user should be able to create a campaign
      can :create, Campaign

      # But only if a campaign exists should an user be able to create content
      if user.campaigns.any?
        can :manage, Campaign do |c|
          c.user == user
        end

        can :manage, Flight do |f|
          f.contract.campaign.user == user
        end

        can :manage, Contract do |c|
          c.campaign.user == user
        end

        can :manage, Reputation do |r|
          r.campaign.user == user
        end
      end
    end
  end
end
