Easycalendar::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root to: "home#show"

  get 'angular_test', to: 'angular_test#index'

  get 'users/profile', to: 'users#profile'

  get '/users/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')
  get '/signout', to: 'sessions#destroy', as: 'signout'
  post '/sessions/user', to:'sessions#create', as: 'signin'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]
end
