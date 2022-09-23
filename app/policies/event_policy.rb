class EventPolicy < ApplicationPolicy
  attr_reader :context, :user, :pincode
  
  def initialize(context, record)
    @context = context
    @record  = record
  end

  delegate :user,    to: :context, allow_nil: true
  delegate :pincode, to: :context, allow_nil: true

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

  class UserWithPincode
    attr_reader :user, :pincode

    def initialize(user, pincode)
      @user     = user
      @pincode  = pincode
    end
  end
end
