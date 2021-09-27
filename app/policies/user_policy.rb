# frozen_string_literal: true

# main authorization class for Users
class UserPolicy < ApplicationPolicy
  # scope for users
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    !@user.nil?
  end

  def update?
    !@user.nil?
  end

  def index?
    !@user.nil?
  end

  def show?
    !@user.nil?
  end
end
