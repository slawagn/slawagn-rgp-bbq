class EventPolicy < ApplicationPolicy
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
    @user.present? && (@record.user == @user)
  end
end
