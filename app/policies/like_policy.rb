# frozen_string_literal: true

# policy for likes
class LikePolicy < ApplicationPolicy
  # scope for users
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    @record.user == @user || @record.user.Public? || @record.user.followers.exists?(@user.id)
  end

  def destroy?
    @record.user == @user
  end
end
