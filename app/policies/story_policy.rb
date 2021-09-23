# frozen_string_literal: true

class StoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user == @record || @record.account_type == 'Public' || @record.followers.exists?(@user.id)
  end

  def destroy?
    @user == @record.user
  end
end
