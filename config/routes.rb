# frozen_string_literal: true

Rails.application.routes.draw do
  get 'organizations/index'
  get 'organizations/show'
  root to: "pages#home"
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    get 'my_events', on: :member
  end
  resources :organizations do
    resources :events, only: [:index, :show]
  end
  resources :events, except: [:destroy] do
    resources :participations, only: [:destroy]
  end
  resources :participations, only: [:create]
  resources :chatrooms, only: [:show, :index] do
    resources :messages, only: :create
    collection do
      get :new_private_conversation
      post :create_private_conversation
    end
  end
end
