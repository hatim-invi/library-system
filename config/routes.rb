Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  resources :users
  resources :sessions
  resources :password_resets
  root 'home#index'
  get 'admin', to: 'admin#index'
  namespace :admin do
    resources :members
    resources :books
    get 'book_upload_files/progress'
    resources :book_upload_files
    get 'book_copies/rooms'
    get 'book_copies/sections'
    get 'book_copies/rackers'
    get 'book_copies/shelfs'
    get 'book_checkout_records/book_info'
    get 'book_checkout_records/member_info'
    get 'book_checkout_records/members_adhaar_number'
    get 'book_checkout_records/checkout'

  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "/:id", to: 'home#show'
end
