# frozen_string_literal: true

Rails.application.routes.draw do
  resources :requests do
    collection do
      post :accept
    end
    member do
      delete :reject
    end
  end
  resources :likes
  resources :posts do
    resources :comments, shallow: true
  end

  post 'followship/create'
  delete 'followship/destroy'
  get 'followship/followers'
  get 'followship/followees'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    resource :profile_picture
    resources :stories
  end

  root to: 'users#index'
end
