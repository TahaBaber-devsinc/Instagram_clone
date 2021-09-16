Rails.application.routes.draw do
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
  end

  root to: 'users#index'
end
