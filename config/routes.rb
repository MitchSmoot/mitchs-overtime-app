Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts
  devise_for :users, skip: [:registrations]
  root to: 'static#homepage'
end
