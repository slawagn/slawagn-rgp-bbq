class PhotoPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.persisted
    end

    private

    attr_reader :user, :scope
  end
end
