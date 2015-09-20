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

  namespace :api do
    namespace :v1 do
      resources :props, only: [:index, :create]
      resources :rankings, only: [:index] do
        get :hero_of_the_week, on: :collection
      end
    end
    resources :users, only: [:index, :show]
    resources :props, only: [:index, :create] do
      resources :upvotes, only: [:create]
      get :total, on: :collection
    end
  end
end
