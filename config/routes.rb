Rails.application.routes.draw do
  root "home#index"

  get "login", to: "sessions#new", as: "login"
  delete "logout", to: "sessions#destroy", as: "logout"
  get "signup", to: "users#new", as: "signup"
  resources :sessions, only: [ :new, :create, :destroy ]
  resources :users, only: [ :new, :create ]
  resources :events, only: [ :index, :new, :create ]
  resources :messages, only: [ :index, :create ]

  mount ActionCable.server => "/cable"
end
