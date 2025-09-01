Rails.application.routes.draw do
  root "home#index"

  get "login", to: "sessions#new", as: "login"
  delete "logout", to: "sessions#destroy", as: "logout"
  get "signup", to: "users#new", as: "signup"
  resources :sessions, only: [ :new, :create, :destroy ]
  resources :users, only: [ :new, :create ]
  resources :events, only: [ :index, :new, :create ] do
    member do
      get "register", to: "registrations#new"
    end
  end
  resources :registrations, only: [ :create ]
  resources :messages, only: [ :index, :create ]

  # Payment routes
  post "/payments/:event_id/checkout", to: "payments#create_checkout_session", as: "payment_checkout"
  get "/payments/:event_id/success", to: "payments#success", as: "payment_success"
  get "/payments/:event_id/cancel", to: "payments#cancel", as: "payment_cancel"

  mount ActionCable.server => "/cable"
end
