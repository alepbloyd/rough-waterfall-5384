Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :customers

  resources :supermarkets

  get "/supermarkets/:id/items", to: "supermarket_items#index"
end
