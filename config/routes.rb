Rails.application.routes.draw do
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/login', to: 'authentication#login'
  post '/signup', to: 'users#create'
  get '/current_user', to: 'authentication#current_user'
end
