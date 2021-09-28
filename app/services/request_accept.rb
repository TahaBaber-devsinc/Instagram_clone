# frozen_string_literal: true

# service class for accepting requests
class RequestAccept
  attr_reader :user, :current_user

  def initialize(user, current_user)
    @user = user
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      user.requests.find_by!(followee_id: @current_user.id).destroy
      user.followships.create!(following_id: @current_user.id)
    end
  rescue ActiveRecord::RecordNotFound => e
    redirect_to @current_user, flash: { notice: e }
  end
end
