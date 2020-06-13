Rails.application.routes.draw do
  get 'articles/index'
  get 'articles/show'
  devise_for :users
  root to: 'pages#home'


  resources :articles, only: [:index, :show, :create, :update] do
    resources :likes, only: [:create, :destroy]
  end

  resources :articles, only: [:index, :show, :create, :update] do
    resources :favorites, only: [:create, :destroy]
  end


end
