Easycalendar::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  get 'angular_test', to: 'angular_test#index'

  get '/users/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')
  get '/signout', to: 'sessions#destroy', as: 'signout'

  get '/users/events', to: 'users#show', as: 'users_events'
  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  get '/profile', to: "users#show"

  root to: "home#show"

  resource :messages do
    collection do
      post 'reply'
    end
  end

end
