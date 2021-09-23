# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :post_likes, only: %i[create destroy]
  resources :comment_likes, only: %i[create destroy]
  resources :followship, only: %i[create destroy]
  resources :posts, except: [:index] do
    resources :comments, except: %i[index show], shallow: true
  end
  resources :users, only: %i[index show update] do
    resource :profile_picture, only: %i[new update]
    resources :stories, only: %i[index new destroy create]
  end
  resources :requests, only: %i[index create destroy] do
    collection do
      post :accept
    end
    member do
      delete :reject
    end
  end

  root to: 'users#show'
end
