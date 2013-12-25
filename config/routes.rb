require 'sidekiq/web'

MarketStreet::Application.routes.draw do
  mount RailsAdmin::Engine => '/rails_admin', :as => 'rails_admin'
  get 'admin' => 'admin/overviews#index'

  get 'login' => 'customer/user_sessions#new'
  delete 'logout' => 'customer/user_sessions#destroy'
  get 'signup' => 'customer/registrations#new'
  
  resources :states,      :only => [:index]  
  resource  :unsubscribe, :only => :show

  get 'about' => 'home#about', as: :about_home
  get 'terms' => 'home#terms', as: :terms_home

  root :to => "home#index"

  #CUSTOMER
  namespace :customer do
    resources :user_sessions, :only => [:new, :create, :destroy]
    resources :registrations,   :only => [:index, :new, :create]
    resource  :password_reset,  :only => [:new, :create, :edit, :update]
    resource  :activation,      :only => [:show]

    resources :orders, :only => [:index, :show]
    resources :addresses
    resources :credit_cards
    resources :referrals, :only => [:index, :create, :update]
    resource  :store_credit, :only => [:show]
    resource  :overview, :only => [:show, :edit, :update]
  end

  namespace :catalog do
    resources :products, :only => [:index, :show, :create]
  end

  #SHOPPING
  namespace :shopping do
    resources :wish_items,  :only => [:index, :destroy]

    resources  :addresses do
      member do
        put :select_address
      end
    end

    resources  :billing_addresses do
      member do
        put :select_address
      end
    end

    resources  :cart_items

    resource  :coupon, :only => [:show, :create]

    resources  :orders do
      member do
        get :checkout
        get :confirmation
      end
    end
    resources  :shipping_methods
  end
  
  #ADMIN
  namespace :admin do
    mount Sidekiq::Web => '/jobs'
    resources :overviews, :only => [:index]

    namespace :customer do
      resources :users do
        resource :store_credits, :only => [:show, :edit, :update]
        resources :addresses
        resources :comments
      end

      resources :referrals do
        member do
          post :apply
        end
      end      
    end

    namespace :reports do
      resource :overview, :only => [:show]
      resources :graphs
      resources :weekly_charts, :only => [:index]
    end
    namespace :rma do
      resources  :orders do
        resources  :return_authorizations do
          member do
            put :complete
          end
        end
      end      
    end

    namespace :history do
      resources  :orders, :only => [:index, :show] do
        resources  :addresses, :only => [:index, :show, :edit, :update, :new, :create]
      end
    end

    namespace :fulfillment do
      resources  :orders do
        member do
          put :create_shipment
        end
        resources  :comments
      end

      namespace :partial do
        resources  :orders do
          resources :shipments, :only => [ :create, :new, :update ]
        end
      end

      resources  :shipments do
        member do
          put :ship
        end
        resources  :addresses , :only => [:edit, :update]# This is for editing the shipment address
      end
    end
    namespace :shopping do
      resources :carts
      resources :products
      resources :users
    end
    namespace :config do
      resources :countries, :only => [:index, :update, :destroy]
      resources :overviews
      resources :shipping_rates
      resources :shipping_methods
      resources :shipping_zones
      resources :tax_rates
      resources :tax_categories
    end

    namespace :offer do
      resources :coupons
      resources :deals
      resources :sales
    end
    namespace :inventory do
      resources :suppliers
      resources :overviews
      resources :purchase_orders
      resources :receivings
      resources :adjustments
    end

    namespace :catalog do
      namespace :images do
        resources :products
      end
      resources :properties
      resources :prototypes
      resources :brands
      resources :product_types
      resources :prototype_properties

      namespace :changes do
        resources :products do
          resource :property,          :only => [:edit, :update]
        end
      end

      namespace :wizards do
        resources :brands,              :only => [:index, :create, :update]
        resources :products,            :only => [:new, :create]
        resources :properties,          :only => [:index, :create, :update]
        resources :prototypes,          :only => [:update]
        resources :tax_categories,        :only => [:index, :create, :update]
        resources :product_types,       :only => [:index, :create, :update]
      end

      namespace :multi do
        resources :products do
          resource :variant,      :only => [:edit, :update]
        end
      end
      resources :products do
        member do
          get :add_properties
          put :activate
        end
        resources :variants
      end
      namespace :products do
        resources :descriptions, :only => [:edit, :update]
      end
    end
    namespace :document do
      resources :invoices
    end
  end
end