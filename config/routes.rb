Rails.application.routes.draw do
	root 'shops#index'

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

	resources :orders do
		collection do
			get 'shops' => "orders#to_shops", :as => :to_shops
			get 'shops/:status/:id' => "orders#show_to_shops", :as => :show_to_shops

			get 'clients' => "orders#from_clients", :as => :from_clients
			get 'clients/:status/:id' => "orders#show_from_clients", :as => :show_from_clients
		end
	end

	resources :shops do
		member do
			get 'cart' => "cart#index", :as => :cart
			get 'add_to_cart/:product_id' => "cart#add", :as => :add_to_cart
			delete 'remove_from_cart/:product_id' => "cart#remove", :as => :remove_from_cart
			delete 'clear_cart' => "cart#clear", :as => :clear_cart

			get 'cart/update_amount/:product_id' => "cart#update_amount", :as => :update_amount
		end
	end

	get 'users/:id/shops' => 'users#shops', :as => :user_shops
	get 'predio/:id/shops' => 'shops#predio', :as => :predio_shops

	resources :users do
		member do
			get :shops
		end
	end



end
