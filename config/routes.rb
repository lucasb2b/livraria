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

  # User
  get '/users/new'
  post '/users/create', to: "users#create", as: "create_user"
  patch '/users/update/:id', to: "users#change_password", as: "change_password"


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

  get '/dashboard/author/all', to: 'authors#index', as: 'show_authors'

  get '/dashboard/author/:id/edit', to: 'authors#edit', as: 'edit_authors'

  patch '/dashboard/author/:id', to: 'authors#update', as: 'update_authors'

  delete '/dashboard/author/destroy_author', to: 'authors#custom_destroy', as: 'destroy_authors'

  # Book
  post '/dashboard/book/', to: 'books#create', as: 'create_book'

  get '/dashboard/book/all', to: 'books#index', as: 'show_books'

  get '/dashboard/book/:id/edit', to: 'books#edit', as: 'edit_books'

  patch '/dashboard/book/:id', to: 'books#update', as: 'update_books'

  delete '/dashboard/book/delete_books_multiple', to: 'books#destroy_multiple', as: 'delete_books_multiple'

  # Supplier
  post '/dashboard/supplier/', to: 'suppliers#create', as: 'create_supplier'

  get '/dashboard/supplier/all', to: 'suppliers#index', as: 'show_suppliers'

  get '/dashboard/supplier/:id/edit', to: 'suppliers#edit', as: 'edit_suppliers'

  patch '/dashboard/supplier/:id', to: 'suppliers#update', as: 'update_suppliers'

  delete '/dashboard/supplier/delete_suppliers', to: 'suppliers#new_destroy', as: 'destroy_suppliers'

  # Account
  post '/dashboard/account/', to: 'accounts#create', as: 'create_account'

  get '/dashboard/account/all', to: 'accounts#index', as: 'show_accounts'

  get '/dashboard/account/:id/edit', to: 'accounts#edit', as: 'edit_accounts'

  patch '/dashboard/account/:id', to: 'accounts#update', as: 'update_accounts'

  delete '/dashboard/account/delete_accounts', to: 'accounts#destroy_ajax', as: 'destroy_accounts'

  # Part
  post '/dashboard/part/', to: 'parts#create', as: 'create_part'

  get '/dashboard/part/all', to: 'parts#index', as: 'show_parts'

  get '/dashboard/part/:id/edit', to: 'parts#edit', as: 'edit_parts'

  patch '/dashboard/part/:id', to: 'parts#update', as: 'update_parts'

  delete '/dashboard/part/delete_parts', to: 'parts#custom_destroy', as: 'destroy_parts'

  # Assembly
  post '/dashboard/assembly/', to: 'assemblies#create', as: 'create_assembly'
  # AssemblyParts
  post '/dashboard/assembly_parts/', to: 'assemblies#assembly_part', as: 'create_assembly_part'
end
