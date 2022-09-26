# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(context, record)
    @context = context
    @record  = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    return false unless @context.user.present?
    
    [@record.user, @record.event.user].include?(@context.user)
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end

  class UserWithPincode
    attr_reader :user, :pincode

    def initialize(user, pincode)
      @user     = user
      @pincode  = pincode
    end
  end
end
