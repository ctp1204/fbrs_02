Rails.application.routes.draw do
  root "books#index"

  get "books/show", to: "books#show"
  get "books/find", to: "books#find"
  get "users/new"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :books
  resources :users
end
