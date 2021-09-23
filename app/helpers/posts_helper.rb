# frozen_string_literal: true

module PostsHelper
  def user_post_btn
    if @post.user_id == current_user.id
      content_tag(:div, class: 'del-upd-btn') do
        button_to('Delete', @post, method: :delete, class: 'btn btn-danger') +
          button_to('Update', edit_post_path, method: :get, class: 'btn btn-warning')
      end
    end
  end

  def user_comment_btn(comment)
    if comment.user == current_user
      content_tag(:div, class: 'del-upd-btn') do
        button_to('Delete', comment_path(id: comment.id), method: :delete, class: 'btn btn-danger ') +
          button_to('Update', edit_comment_path(comment.id), method: :get, class: 'btn btn-warning ')
      end
    end
  end

  def user_post_comment_btn(comment)
    if @post.user == current_user && comment.user != current_user
      button_to 'Delete', comment, method: :delete, class: 'btn btn-danger '
    end
  end

  def comment_like_btn(comment)
    content_tag(:div) do
      button_to('Liked', comment_like_path(id: comment.id, like_id: comment.likes.find_by_user_id(current_user.id)),
                method: :delete, class: 'btn btn-danger ', id: "dislike-comment-btn-#{comment.id}", remote: true) +
        button_to('Like', comment_likes_path(id: comment.id), method: :post, class: 'btn btn-outline-danger ',
                                                              id: "like-comment-btn-#{comment.id}", remote: true)
    end
  end

  def post_like_btn
    content_tag(:div) do
      button_to('Liked', post_like_path(id: @post.id), method: :delete, class: 'btn btn-danger',
                                                       id: 'dislike-post-btn', remote: true) +
        button_to('Like', post_likes_path(id: @post.id), method: :post, class: 'btn btn-outline-danger',
                                                         id: 'like-post-btn', remote: true)
    end
  end
end
