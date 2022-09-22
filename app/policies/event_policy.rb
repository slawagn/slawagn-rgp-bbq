class EventPolicy < ApplicationPolicy
  attr_reader :context, :user, :cookies, :params
  
  def initialize(context, record)
    @context = context
    @record  = record
  end

  delegate :user,    to: :context
  delegate :cookies, to: :context
  delegate :params,  to: :context

  def show?
    if params[:pincode].present? && @record.pincode_valid?(params[:pincode])
      cookies.permanent["event_#{@record.id}_pincode"] = params[:pincode]
    end

    if @record.pincode.blank?
      true
    elsif user == @record.user
      true
    elsif @record.pincode_valid?(cookies.permanent["event_#{@record.id}_pincode"])
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
end
