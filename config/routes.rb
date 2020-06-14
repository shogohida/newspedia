Rails.application.routes.draw do
  get 'users/show'
  # get 'websites/index'
  # get 'websites/show'
  # get 'articles/index'
  # get 'articles/show'
  devise_for :users
  root to: 'pages#home'
  # root to: "websites#index" ??

  resources :users, only: :show

  resources :websites, only: [:index, :show, :update] do
    resources :articles, only: [:index, :show, :create]
    # nest with article show?
    # no article create?
  end

  # no article actions?
  resources :articles, only: [:index, :show, :create, :update] do
    resources :likes, only: [:create, :destroy]
  end

  resources :articles, only: [:index, :show, :create, :update] do
    resources :favorites, only: [:create, :destroy]
  end
end
