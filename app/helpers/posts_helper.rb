# frozen_string_literal: true

module PostsHelper
  def user_post_btn
    return unless @post.user_id == current_user.id

    content_tag(:div, class: 'del-upd-btn') do
      button_to('Delete', @post, method: :delete, class: 'btn btn-danger') +
        button_to('Update', edit_post_path, method: :get, class: 'btn btn-warning')
    end
  end

  def user_comment_btn(comment)
    return unless comment.user == current_user

    content_tag(:div, class: 'del-upd-btn') do
      button_to('Delete', comment_path(id: comment.id), method: :delete, class: 'btn btn-danger ') +
        button_to('Update', edit_comment_path(comment.id), method: :get, class: 'btn btn-warning ')
    end
  end

  def user_post_comment_btn(comment)
    return unless @post.user == current_user && comment.user != current_user

    button_to 'Delete', comment, method: :delete, class: 'btn btn-danger '
  end

  def comment_like_btn(comment)
    content_tag(:div) do
      button_to('Liked', comment_like_path(id: comment.id, like_id: comment.likes.find_by_user_id(current_user.id)),
                method: :delete, class: "btn btn-danger #{comment_dislike_show(comment)}",
                id: "dislike-comment-btn-#{comment.id}", remote: true) +
        button_to('Like', comment_likes_path(id: comment.id),
                  method: :post, class: "btn btn-outline-danger #{comment_like_show(comment)}",
                  id: "like-comment-btn-#{comment.id}", remote: true)
    end
  end

  def post_like_btn
    content_tag(:div) do
      button_to('Liked', post_like_path(id: @post.id), method: :delete, class: "btn btn-danger #{post_dislike_show}",
                                                       id: 'dislike-post-btn', remote: true) +
        button_to('Like', post_likes_path(id: @post.id), method: :post,
                                                         class: "btn btn-outline-danger #{post_like_show}",
                                                         id: 'like-post-btn', remote: true)
    end
  end

  def post_like_show
    'none' if @post.likes.exists?(user_id: current_user.id)
  end

  def post_dislike_show
    'none' unless @post.likes.exists?(user_id: current_user.id)
  end

  def comment_like_show(comment)
    'none' if comment.likes.exists?(user_id: current_user.id)
  end

  def comment_dislike_show(comment)
    'none' unless comment.likes.exists?(user_id: current_user.id)
  end
end
