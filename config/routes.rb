Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
  get "sign_up" => "users#new"
  post "users/create" => "users#create"
  resources :books
  resources :users
  resources :homes, only: [:new, :cerate, :show]
end
