Rails.application.routes.draw do
  
  devise_for :users,
    controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
  }

  resources :queries
  resources :accounts
  resources :bancos
  resources :pagos
  resources :members
  resources :alejandros
  resources :predios
  resources :categories
  resources :products
  resources :shops

  root 'shops#index'
  
  get 'users/:id/shops' => 'users#shops', :as => :user_shops

  resources :users do
    member do
      get :shops
    end
  end
  
  
  
end
