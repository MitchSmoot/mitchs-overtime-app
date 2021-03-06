Rails.application.routes.draw do
  resources :audit_logs, except: [:new, :edit, :destroy] do
    member do
      get :confirm
    end
  end

  namespace :admin do
    resources :users
    resources :posts
    resources :admin_users
    resources :employees
    root to: "users#index"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    member do
      get :approve
    end
  end
  devise_for :users, skip: [:registrations]
  root to: 'static#homepage'
end
