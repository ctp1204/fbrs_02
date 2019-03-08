Rails.application.routes.draw do
  root "static_pages#Home"
  get "static_pages/Help"
end
