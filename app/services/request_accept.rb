# frozen_string_literal: true

# service class for accepting requests
class RequestAccept
  def initialize(user, current_user)
    @user = user
    @current_user = current_user
  end

  def call
    request.transaction do
      followship.transaction do
        request = @user.requests.find_by(followee_id: @current_user.id)
        request.destroy
        followship = @user.followships.build(following_id: @current_user.id)
        followship.save
      end
    end
  end
end
