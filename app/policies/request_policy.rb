# frozen_string_literal: true

# main authorization class for rquest
class RequestPolicy < ApplicationPolicy
  # scope for requests
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def reject?
    @record.followee_id == @user.id
  end
end
