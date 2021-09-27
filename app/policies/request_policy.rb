# frozen_string_literal: true

# main authorization class for rquest
class RequestPolicy < ApplicationPolicy
  # scope for requests
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    !@user.nil?
  end

  def create?
    !@user.followees.exists?(@record) && !@user.requests.exists?(followee_id: @record)
  end

  def destroy?
    @user.requests.exists?(followee_id: @record)
  end

  def accept?
    @record.requests.exists?(followee_id: @user.id)
  end

  def reject?
    @record.followee_id == @user.id
  end
end
