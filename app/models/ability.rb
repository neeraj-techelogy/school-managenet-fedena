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
        can :read, Store
        can :read, ItemCategory
        can :read, Item

        can :read, Indent
        can :manage, Indent, :user_id => user.id

        can :read, PurchaseOrder
        can :manage, PurchaseOrder, :user_id => user.id

        can :read, Invoice
        can :manage, Invoice, :user_id => user.id
      end

      if user.student?

      end

      if user.student? || user.employee?
        can :read, SupportRequest
        can :update_status, SupportRequest, :assignee_id => user.id
        can :accept, SupportRequest, :reporter_id => user.id
        can :manage, SupportRequest, :reporter_id => user.id

        can :read, SupportRequestReply
        can :manage, SupportRequestReply, :user_id => user.id

        can :read, SupplierType
      end
    else
      # Not logged in

    end




  end
end
