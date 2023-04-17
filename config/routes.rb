Rails.application.routes.draw do
  get 'sessions/new'

  post '/line_bot/callback', to: 'line_bot#callback'


  root 'static_pages#top'
  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    resources :trains do
      collection do
        get 'past_trains'
      end
    end
    get 'part', on: :member
  end
end
