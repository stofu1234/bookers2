Rails.application.routes.draw do
  #get 'users/show'
  devise_for :users
  get 'home/about', to: 'homes#about'
  root to: 'homes#top'

  resources :users, only: [:show, :edit, :update, :index]
  resources :books, only: [:show, :edit, :update, :create, :new, :index, :destroy]

end
