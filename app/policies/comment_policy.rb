class CommentPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.reject { |comment| comment.new_record? }
    end

    private

    attr_reader :user, :scope
  end
end
