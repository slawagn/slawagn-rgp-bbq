class EventPolicy < ApplicationPolicy
  attr_reader :context, :user, :pincode
  
  delegate :user,    to: :context, allow_nil: true
  delegate :pincode, to: :context, allow_nil: true

  def index?
    true
  end

  def new?
    create?
  end

  def show?
    if @record.pincode.blank?
      true
    elsif user == @record.user
      true
    elsif @record.pincode_valid?(pincode)
      true
    else
      false
    end
  end

  def edit?
    event_owned_by_user?
  end

  def create?
    user.present?  
  end

  def update?
    event_owned_by_user?
  end

  def destroy?
    event_owned_by_user?
  end

  private

  def event_owned_by_user?
    user.present? && (@record.user == user)
  end
  
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
