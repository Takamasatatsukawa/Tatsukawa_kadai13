Rails.application.routes.draw do
  
  resources :tasks
  resources :sessions, only: [:new, :create, :show, :edit, :destroy]
  #:show, :edit,を追加
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  root 'tasks#index'
end
