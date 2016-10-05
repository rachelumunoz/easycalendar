Easycalendar::Application.routes.draw do
  resources :events
   # devise_for :users, controllers: { omniauth_callbacks: 'static_pages#set_google_event_token'}
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :appointments
  get 'angular_test', to: 'angular_test#index'

  get '/users/auth/:provider/callback', to: 'static_pages#set_google_drive_token'
  get '/auth/failure', to: redirect('/')
  get '/signout', to: 'sessions#destroy', as: 'signout'


  get '/users/events', to: 'users#events', as: 'users_events'
  get '/users/calendar', to: "users#calendar", as: 'users_calendar'

  get '/users/events-appts', to: "users#showappts"
  get '/invite', to: "invites#new"
  post '/invite', to: "invites#create", as: "invites"


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
