Rails.application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get 'merchants/random', to: 'merchants#random'
      get 'merchants/find', to: 'merchants#search'
      get 'merchants/find_all', to: 'merchants#find_all'
      get 'merchants/most_revenue', to: 'merchants#top_revenue'
      resources :merchants, only: [:show] do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end

      get 'customers/random', to: 'customers#random'
      get 'customers/find', to: 'customers#search'
      get 'customers/find_all', to: 'customers#find_all'
      resources :customers, only: [:show] do
        resources :invoices, only: [:index]
        get '/transactions', to: 'customers#transactions'
      end

      get 'items/random', to: 'items#random'
      get 'items/find', to: 'items#search'
      get 'items/find_all', to: 'items#find_all'
      resources :items, only: [:show] do
        resources :invoice_items, only: [:index]
        get '/merchant', to: 'items#merchant'
      end

      get 'invoices/random', to: 'invoices#random'
      get 'invoices/find', to: 'invoices#search'
      get 'invoices/find_all', to: 'invoices#find_all'
      resources :invoices, only: [:show] do
        resources :transactions, only: [:index]
        resources :invoice_items, only: [:index]
        resources :items, only: [:index]
        get '/customer', to: 'invoices#customer'
        get '/merchant', to: 'invoices#merchant'
      end

      get 'transactions/random', to: 'transactions#random'
      get 'transactions/find', to: 'transactions#search'
      get 'transactions/find_all', to: 'transactions#find_all'
      resources :transactions, only: [:show] do
        get '/invoice', to: 'transactions#invoice'
      end

      get 'invoice_items/random', to: 'invoice_items#random'
      get 'invoice_items/find', to: 'invoice_items#search'
      get 'invoice_items/find_all', to: 'invoice_items#find_all'
      resources :invoice_items, only: [:show] do
        get '/invoice', to: 'invoice_items#invoice'
        get '/item', to: 'invoice_items#item'
      end
    end
  end
end
