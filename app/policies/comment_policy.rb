# frozen_string_literal: true

# main authorization class for comments
class CommentPolicy < ApplicationPolicy
  # scope for comment authorization
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    create?
  end

  def create?
    post_user = @record.post.user
    post_user == @user || post_user.Public? || post_user.followers.exists?(@user.id)
  end

  def destroy?
    @record.user == @user || @record.post.user == @user
  end

  def edit?
    update?
  end

  def update?
    @record.user == @user
  end
end
