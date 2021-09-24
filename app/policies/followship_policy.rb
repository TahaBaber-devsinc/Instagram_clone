# frozen_string_literal: true

# main authorization class for followship
class FollowshipPolicy < ApplicationPolicy
  # scope for followship class
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    id = @record.following_id
    id != @user.id && !@user.followships.exists?(following_id: id)
  end
end
