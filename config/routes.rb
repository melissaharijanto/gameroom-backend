Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :followings
  resources :game_communities
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/login', to: 'authentication#login'
  post '/signup', to: 'users#create'
  get '/current_user', to: 'authentication#current_user'
  get '/follow', to: 'game_communities#get_user_following'
  post '/follow', to: 'game_communities#follow'
  post '/search', to: 'game_communities#search'
  post '/community_posts', to: 'posts#get_posts_by_community_id'
  post '/post_likes', to: 'posts#set_likes'
  post '/comments', to: 'comments#get_comments_by_post_id'
  post '/comment_likes', to: 'comments#set_likes'

end
