Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :customers
      resources :products, only: [:index, :show]
      resources :orders, only [:index, :create, :show, :ship]
    end
  end
end
