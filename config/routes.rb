GoodPrinciples::Application.routes.draw do
  get "users/new"
  
  resources :sessions,      only: [:new, :create, :destroy, :create_fb, :destroy_fb]
  resources :users
  root to: 'static_pages#home'

  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"
  get "static_pages/contact" 
  
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete  
  match '/signup',  to: 'users#new'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match 'auth/facebook/callback', to: 'sessions#createFromOmniauth'
  

end
