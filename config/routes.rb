Rails.application.routes.draw do
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'
  # get 'sessions/home'
  # get 'home/home'
  #
  root 'home#home'

  # Login
  resources :sessions, only: [:new, :create] do
    collection do
      delete "sign_out", to: "sessions#destroy", as: "sign_out"
    end
  end

  # Dashboard
  get '/dashboard', to: 'dashboard#show'
  get '/dashboard/author', to: 'dashboard#author'
  get '/dashboard/book', to: 'dashboard#book'
  get '/dashboard/supplier', to: 'dashboard#supplier'
  get '/dashboard/part', to: 'dashboard#part'
  get '/dashboard/assembly', to: 'dashboard#assembly'

  # Author
  post '/dashboard/author/', to: 'authors#create', as: 'create_author'
  # Book
  post '/dashboard/book/', to: 'books#create', as: 'create_book'
  # Supplier
  post '/dashboard/supplier/', to: 'suppliers#create', as: 'create_supplier'
end
