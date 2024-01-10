Rails.application.routes.draw do

  namespace :admin do
    root to: "homes#top"
    resources :users, only: [:index, :show, :edit, :update]
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
    resources :notifications, only: [:create, :index] do
      post 'deliver', on: :collection
    end
    resources :posts, only: [:index, :show]
    resources :articles, only: [:index, :new, :create, :show, :edit, :update]
  end

  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
    resources :notifications, only: [:index, :show, :update]
    resources :favorites, only: [:index, :show, :create, :update, :destroy]
    resources :posts, only: [:index, :new, :create, :show, :edit, :update]
    resources :users, only: [:show, :edit, :update]
      get "users/mypage" => "users#show"
    resources :articles, only: [:index, :show]
  end

  devise_for :user
  devise_for :admin

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
