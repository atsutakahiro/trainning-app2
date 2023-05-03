Rails.application.routes.draw do
  get 'sessions/new'

  post '/line_bot/callback', to: 'line_bot#callback'

  root 'static_pages#top'
  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    member do
      get 'line', action: :line_id
    end
    resources :trains do
      collection do
        get 'past_trains'
        get 'input_exercise'
        get 'past_update'
      end
      member do
        get 'past_edit', action: :past_edit
      end
    end
    get 'part', on: :member
  end
end
