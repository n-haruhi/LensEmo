Rails.application.routes.draw do
  namespace :public do
    get 'tags/index'
    get 'tags/edit'
  end
  namespace :public do
    get 'notifications/index'
    get 'notifications/show'
  end
  namespace :public do
    get 'favorites/index'
    get 'favorites/show'
  end
  namespace :public do
    get 'posts/index'
    get 'posts/new'
    get 'posts/show'
    get 'posts/edit'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
  end
  namespace :public do
    get 'articles/index'
    get 'articles/show'
  end
  devise_for :users
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
