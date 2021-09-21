# frozen_string_literal: true

class RequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def reject?
    @record.followee_id == @user.id
  end
end
