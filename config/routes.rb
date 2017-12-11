Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :posts
    resources :admin_users
    root to: "users#index"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts
  devise_for :users, skip: [:registrations]
  root to: 'static#homepage'
end
