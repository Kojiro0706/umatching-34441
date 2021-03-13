Rails.application.routes.draw do
  devise_for :users
  root to: "builders#index"
  get 'builders/search'
  resources :builders do
    resources :comments,only: [:create]
  end
  resources :users,only:  [:show]
end
