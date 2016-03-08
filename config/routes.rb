Rails.application.routes.draw do
  mount EasyTokens::Engine, at: 'et'
  root 'home#index'
  get 'app' => 'authenticated#main_app'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', as: :signin
  get '/signout' => 'sessions#destroy', as: :signout
  get '/auth/failure' => 'sessions#failure'

  resources :settings, only: :index do
    post :apply, on: :collection
  end

  mount Api::Base, at: '/api'

  namespace :api do
    resources :rankings, only: [:index], path: 'v1/rankings' do
      get :hero_of_the_week, on: :collection
    end
    resources :users, only: [:index, :show], path: 'v1/users'
    resources :props, only: [:index, :create], path: 'v1/props' do
      resources :upvotes, only: [:create]
      get :total, on: :collection
    end
  end
end
