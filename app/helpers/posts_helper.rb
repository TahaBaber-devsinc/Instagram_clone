# frozen_string_literal: true

# this is a helper for views of post class
module PostsHelper
  def user_post_btn(post)
    return unless post.user_id == current_user.id

    tag.div(class: 'del-upd-btn') do
      button_to(edit_post_path, method: :get, class: 'btn btn-warning') { image_tag('edit_icon') } +
        button_to(post, method: :delete, class: 'btn btn-danger') { image_tag('trash') }
    end
  end

  def user_comment_btn(comment)
    return unless comment.user == current_user

    tag.div(class: 'del-upd-btn') do
      button_to(edit_comment_path(comment.id), method: :get, class: 'btn btn-warning ') do
        image_tag('edit_icon')
      end +
        button_to(comment_path(id: comment.id), method: :delete, class: 'btn btn-danger ') { image_tag('trash') }
    end
  end

  def user_post_comment_btn(post, comment)
    return unless post.user == current_user && comment.user != current_user

    button_to(comment, method: :delete, class: 'btn btn-danger ') { render 'trash' }
  end

  def comment_like_btn(comment)
    tag.div do
      button_to('Liked', comment_like_path(id: comment.id, like_id: comment.likes.find_by(user_id: current_user.id)),
                method: :delete, class: "btn btn-danger #{comment_dislike_show(comment)}",
                id: "dislike-comment-btn-#{comment.id}", remote: true) +
        button_to('Like', comment_likes_path(id: comment.id),
                  method: :post, class: "btn btn-outline-danger #{comment_like_show(comment)}",
                  id: "like-comment-btn-#{comment.id}", remote: true)
    end
  end

  def post_like_btn(post)
    tag.div do
      button_to('Liked', post_like_path(id: post.id),
                method: :delete, class: "btn btn-danger #{post_dislike_show(post)}",
                id: 'dislike-post-btn', remote: true) +
        button_to('Like', post_likes_path(id: post.id), method: :post,
                                                        class: "btn btn-outline-danger #{post_like_show(post)}",
                                                        id: 'like-post-btn', remote: true)
    end
  end

  def post_like_show(post)
    'none' if post.likes.exists?(user_id: current_user.id)
  end

  def post_dislike_show(post)
    'none' unless post.likes.exists?(user_id: current_user.id)
  end

  def comment_like_show(comment)
    'none' if comment.likes.exists?(user_id: current_user.id)
  end

  def comment_dislike_show(comment)
    'none' unless comment.likes.exists?(user_id: current_user.id)
  end
end
