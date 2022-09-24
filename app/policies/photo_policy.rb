class PhotoPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.reject { |photo| photo.new_record? }
    end

    private

    attr_reader :user, :scope
  end
end
