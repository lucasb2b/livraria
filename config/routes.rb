Rails.application.routes.draw do
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'
  # get 'sessions/home'
  # get 'home/home'
  #
  root 'home#home'

  # Formulário de Login
  get '/login', to: 'sessions#new', as: 'sessions'

  # Rota para lidar com a submissão do formulário de sessions
  post '/login', to: 'sessions#create'

  # Rota para logout
  delete '/logout', to: 'sessions#destroy', as: 'logout'
end
