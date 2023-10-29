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
  get '/dashboard/account', to: 'dashboard#account'
  get '/dashboard/part', to: 'dashboard#part'
  get '/dashboard/assembly', to: 'dashboard#assembly'

  # Author
  post '/dashboard/author/', to: 'authors#create', as: 'create_author'

  # Book
  post '/dashboard/book/', to: 'books#create', as: 'create_book'

  get '/dashboard/book/all', to: 'books#index', as: 'show_books'

  get '/dashboard/book/:id/edit', to: 'books#edit', as: 'edit_books'

  patch '/dashboard/book/:id', to: 'books#update', as: 'update_books'

  delete '/dashboard/book/delete_books_multiple', to: 'books#destroy_multiple', as: 'delete_books_multiple'

  # Supplier
  post '/dashboard/supplier/', to: 'suppliers#create', as: 'create_supplier'
  # Account
  post '/dashboard/account/', to: 'accounts#create', as: 'create_account'
  # Part
  post '/dashboard/part/', to: 'parts#create', as: 'create_part'
  # Assembly
  post '/dashboard/assembly/', to: 'assemblies#create', as: 'create_assembly'
  # AssemblyParts
  post '/dashboard/assembly_parts/', to: 'assemblies#assembly_part', as: 'create_assembly_part'
end
