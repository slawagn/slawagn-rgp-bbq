class CommentPolicy < ApplicationPolicy
  def destroy?
    @user.present? && (@record.user == @user || @record.event.user == @user )
  end
end
