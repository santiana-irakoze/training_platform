Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :tests do
    resources :responses, only: [:new, :create]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get '/dashboard_students', to: 'pages#dashboard_students', as: :dashboard_students
  get '/dashboard_admins', to: 'pages#dashboard_admins', as: :dashboard_admins

  # Defines the root path route ("/")
  # root "posts#index"
end
