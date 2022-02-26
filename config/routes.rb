Rails.application.routes.draw do
  devise_for :users
  root to: 'memos#index'
  resources :memos, only: [:new, :create, :show, :edit, :update]
end