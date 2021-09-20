class FollowshipPolicy < ApplicationPolicy
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
