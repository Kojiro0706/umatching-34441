Rails.application.routes.draw do
  devise_for :users
  root to: "builders#index"
  resources :builders,only: [:index,:new,:create,:show]
end
