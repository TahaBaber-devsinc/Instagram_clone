# frozen_string_literal: true

# this is a helper for views of user class
module UsersHelper
  DEFAULT_PROFILE_PIC = 'https://www.gravatar.com/avatar/8063e2e1dcc866a5ffaddafdc2fd49f4?size=192&d=mm'

  def profile_pic(user)
    tag.div(class: 'profile-pic-div') do
      if user.image.attached?
        link_to image_tag(user.image, width: '150', height: '150', class: 'profile-pic'), user
      else
        link_to image_tag(DEFAULT_PROFILE_PIC,
                          width: '150', height: '150', class: 'profile-pic'), user
      end
    end
  end

  def user_profile_pic_helper(user)
    if user.image.attached?
      link_to image_tag(user.image, width: '150', height: '150', class: 'profile-pic border border-3'),
              new_user_profile_picture_path(current_user)
    else
      link_to image_tag(DEFAULT_PROFILE_PIC,
                        width: '150', height: '150', class: 'profile-pic border border-3'),
              new_user_profile_picture_path(current_user)
    end
  end

  def image_check(user)
    if user.image.attached?
      link_to image_tag(user.image, width: '150', height: '150', class: 'profile-pic border border-3'),
              user_stories_path(user)
    else
      link_to image_tag(DEFAULT_PROFILE_PIC,
                        width: '150', height: '150', class: 'profile-pic border border-3'),
              user_stories_path(user)
    end
  end

  def user_profile_pic(user)
    tag.div(class: 'profile-pic-div') do
      if user == current_user
        user_profile_pic_helper(user)
      else
        image_check(user)
      end
    end
  end

  def public_user_btn(user)
    return unless user.Public?

    button_to('Follow', followship_index_path(following_id: user),
              method: :post, id: 'folow-btn',
              class: "btn btn-outline-dark follow-btn #{follow_exist(user)}", remote: true) +
      button_to('Unfollow', followship_path(following_id: user),
                method: :delete, id: 'unfolow-btn',
                class: "btn btn-outline-secondary  #{follow_not_exist(user)}", remote: true)
  end

  def private_user_btn(user)
    return if user.Public?

    button_to('Request', requests_path(id: user.id),
              method: :post, id: 'request-btn',
              class: "btn btn-outline-dark follow-btn #{request_exist(user)} #{follow_exist(user)}", remote: true) +
      button_to('Cancel Request', request_path(id: user.id),
                method: :delete, id: 'unrequest-btn',
                class: "btn btn-outline-dark follow-btn #{request_not_exist(user)}", remote: true) +
      button_to('Unfollow', followship_path(following_id: user),
                method: :delete, id: 'unfolow-btn',
                class: "btn btn-outline-secondary #{follow_not_exist(user)}", remote: true)
  end

  def account_btn
    button_to('Private', user_path(current_user), method: :put, class: "btn btn-outline-secondary #{account_private}",
                                                  id: 'private-btn', remote: true) +
      button_to('Public', user_path(current_user), method: :put, class: "btn btn-outline-secondary #{account_public}",
                                                   id: 'public-btn', remote: true) +
      button_to('View Requests', requests_path, method: :get, class: "btn btn-outline-secondary #{account_public}",
                                                id: 'request-btn')
  end

  def story_btn(user)
    button_to('Add Story', new_user_story_path(user_id: user.id), method: :get, class: 'btn btn-outline-dark') +
      button_to('View Story', user_stories_path(user_id: user.id), method: :get, class: 'btn btn-outline-dark')
  end

  def follow_exist(user)
    'none' if current_user.followships.exists?(following_id: user.id)
  end

  def follow_not_exist(user)
    'none' unless current_user.followships.exists?(following_id: user.id)
  end

  def request_exist(user)
    'none' if current_user.requests.exists?(followee_id: user.id)
  end

  def request_not_exist(user)
    'none' unless current_user.requests.exists?(followee_id: user.id)
  end

  def account_public
    'none' if current_user.Public?
  end

  def account_private
    'none' unless current_user.Public?
  end

  def condition(user)
    user != current_user && !user.followers.exists?(current_user.id) && user.Private?
  end
end
