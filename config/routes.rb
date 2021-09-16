# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/index'
  get 'followship/create'
  get 'followship/destroy'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'users#index'
end
