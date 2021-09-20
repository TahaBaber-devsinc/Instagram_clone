# frozen_string_literal: true

class StoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    story_user = @record.user
    @user == story_user || story_user.account_type == 'Public' || story_user.followers.exists?(@user.id)
  end

  def destroy?
    @user == @record.user
  end
end
