# frozen_string_literal: true

# main authorization class for stories
class StoryPolicy < ApplicationPolicy
  # scope for stories
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user == @record || @record.account_type == 'Public' || @record.followers.exists?(@user.id)
  end

  def create?
    @record.user == @user
  end

  def destroy?
    @user == @record.user
  end
end
