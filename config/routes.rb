Rails.application.routes.draw do

  # adminのルーティングをnamespaceでまとめる
  namespace :admin do
    root to: "homes#top"
    resources :users, only: [:index, :show, :edit, :update]
    resources :tags, only: [:index, :create, :edit, :update, :destroy]

    # notificationsリソースに対してdeliverという名前のアクションを生成する
    # このアクションはcollectionに対してPOSTリクエストが送られた場合に呼び出される
    resources :notifications, only: [:new, :create, :send, :show, :index] do
      post 'deliver', on: :collection
    end

    resources :favorites, only: [:index, :show, :destroy]
    resources :posts, only: [:index, :show]
    resources :articles, only: [:index, :new, :create, :show, :edit, :update]
  end

  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
    resources :notifications, only: [:index, :show, :update]
    resources :favorites, only: [:create, :destroy]
    resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :users, only: [:edit, :update]
      get "users/mypage" => "users#show", as: :users_mypage
    resources :articles, only: [:index, :show]
  end

  devise_for :users, skip: [:passwords],
    controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }

  devise_for :admin, skip: [:registrations, :passwords] ,
    controllers: {
      sessions: 'admin/sessions'
    }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
