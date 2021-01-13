Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'

 get '/login' => 'sessions#new'
 post '/login' => 'sessions#create'
 post '/logout' => 'sessions#destroy'

 resources :users

 root 'sessions#new'
 get 'sessions/new' => 'sessions#new'

 resources :wines do
    resources :foods, only: [:show, :index, :new]
  end

  # get 'wines/:id/foods', to: 'wines#foods_index' #nested routing
  # get 'wines/:id/foods/:food_id', to:'wines#food' #nested routing

  resources :foods

  resources :pairings
  
end
