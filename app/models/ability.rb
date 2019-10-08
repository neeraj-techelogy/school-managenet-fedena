class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, :to => :crud

    if user.id
      if user.admin?
        can :manage, :all
      end

      if user.admin? || user.employee?

      end

      if user.employee?

      end

      if user.student?

      end

      if user.student? || user.employee?
        can :read, SupportRequest
        can :update_status, SupportRequest, :assignee_id => user.id
        can :accept, SupportRequest, :reporter_id => user.id
        can :manage, SupportRequest, :reporter_id => user.id
        can :manage, SupportRequestReply, :user_id => user.id
      end
    else
      # Not logged in

    end




  end
end
