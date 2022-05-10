Rails.application.routes.draw do
  resources :line_items
  resources :invoices
  resources :services
  resources :products
  resources :clients

  root to: redirect("/invoices")
end
