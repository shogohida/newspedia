Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users, only: [:show, :edit, :update]

  resources :websites, only: [:index, :show, :update] do
    resources :articles, only: [:index, :show]
  end

  resources :articles, only: [:show] do
    resources :likes, only: [:create, :destroy]
  end

  resources :articles, only: [:show] do
    resources :favorites, only: [:create, :destroy]
  end
end
