Rails.application.routes.draw do
  root "home#show"

  get "login", to: "sessions#new", as: "login"
  delete "logout", to: "sessions#destroy", as: "logout"
  get "signup", to: "users#new", as: "signup"
  resources :sessions, only: [ :new, :create, :destroy ]
  resources :users, only: [ :new, :show, :create ]
end
