Rails.application.routes.draw do
  get 'websites/index'
  get 'websites/show'
  get 'articles/index'
  get 'articles/show'
  devise_for :users
  root to: 'pages#home'
  # root to: "websites#index" ??

  resources :websites, only: [:index, :show, :update]
  # nest witn article show?

  resources :articles, only: [:index, :show, :create, :update] do
    resources :likes, only: [:create, :destroy]
  end

  resources :articles, only: [:index, :show, :create, :update] do
    resources :favorites, only: [:create, :destroy]
  end


end
