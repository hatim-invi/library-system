Rails.application.routes.draw do
  root 'home#index'
  get 'admin', to: 'admin#index'
  namespace :admin do
    resources :members
    resources :books
    get 'book_copies/rooms'
    get 'book_copies/sections'
    get 'book_copies/racks'
    get 'book_copies/shelfs'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "/:id", to: 'home#show'
end
