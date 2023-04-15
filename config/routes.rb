Rails.application.routes.draw do
  get 'sessions/new'

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
