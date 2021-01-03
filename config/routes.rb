Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'

 get '/login' => 'sessions#new'
 post '/login' => 'sessions#create'
 post '/logout' => 'sessions#destroy'

 resources :users

 root 'welcome#home'
 get 'welcome/home' => 'welcome#home'

 resources :wines do
    resources :foods, only: [:show, :index, :new, :edit]
  end

  resources :foods

  resources :pairings
  
end
