Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # login as a test user
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root to: 'pages#home'
  get '/privacy', to: 'pages#privacy'

  resources :users, only: [:show, :edit, :update]

  resources :websites, only: [:show, :update] do
    resources :articles, only: [:index, :show]
  end

  resources :articles, only: [:show] do
    resources :likes, only: [:create, :destroy]
  end

  resources :articles, only: [:show] do
    resources :favorites, only: [:create, :destroy]
  end
end
