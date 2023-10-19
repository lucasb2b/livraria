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

  # Formulário de Login
  #get '/login', to: 'sessions#new', as: 'sessions'

  # Rota para lidar com a submissão do formulário de sessions
  #post '/login', to: 'sessions#create'

  # Rota para logout
  #delete '/logout', to: 'sessions#destroy', as: 'logout'
end
