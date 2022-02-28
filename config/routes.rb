Rails.application.routes.draw do
  devise_for :users
  root to: 'memos#index'
  resources :memos, only:[:new, :create, :edit, :update, :destroy] do
    collection do
      get 'search'
    end
  end
end