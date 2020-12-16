Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :wines, only: [:show, :index] do
    resources :foods, only: [:show, :index, :new]
  end

  resources :foods

  resources :users
  
end
