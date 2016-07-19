Rails.application.routes.draw do

  get '/' => 'posts#index', as: :index
  resources :posts do
    resources :comments
    resources :favourites, only: [:create, :destroy]
  end

  resources :favourites, only: [:index]
  
  resources :users, only: [:new, :create, :edit, :update] do
    collection do
      get :change_password
      post 'change_password' => :update_password
    end
    delete :destroy, on: :collection
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  # Routes for the api
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :posts
    end
  end

  # Routes for omniauth

  get '/auth/google_oauth2', as: :sign_in_with_google
  get '/auth/google_oauth2/callback' => 'callbacks#index'
  
  # get '/' => 'posts#index', as: :index
  # get '/posts/new' => 'posts#new', as: :new_post
  # post '/posts' => 'posts#create', as: :posts
  # get '/posts/:id' => 'posts#show', as: :post
  # get '/posts/:id/edit' => 'posts#edit', as: :edit_post
  # patch '/posts/:id' => 'posts#update'
  # delete '/posts/:id' => 'posts#destroy'
  # get '/posts' => 'posts#index'

  #search
  get '/search' => 'home#search', as: :search
  get '/search/results' => 'home#results', as: :results

  get '/about' => 'home#about', as: :about
  
end
