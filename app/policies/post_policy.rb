# frozen_string_literal: true

# main authorization class for post
class PostPolicy < ApplicationPolicy
  # scope for posts
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    post_user = @record.user
    @user == post_user || post_user.Public? || post_user.followers.exists?(@user.id)
  end

  def edit?
    @user == @record.user
  end

  def update?
    @user == @record.user
  end

  def destroy?
    @user == @record.user
  end
end
