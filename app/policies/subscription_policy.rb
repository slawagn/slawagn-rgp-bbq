class SubscriptionPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.reject { |subscription| subscription.new_record? }
    end

    private

    attr_reader :user, :scope
  end
end
