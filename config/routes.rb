Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :tests do
    resources :responses, only: [:new, :create]
    collection do
      get :admin_index
    end
  end

  # Admin routes for managing users
  resources :users, only: [:destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'tests/new/', to: 'tests#new', as: :new_with_id_test
  get '/dashboard_students', to: 'pages#dashboard_students', as: :dashboard_students
  get '/dashboard_students/preview', to: 'pages#preview', defaults: { format: 'html' }
  get '/dashboard_students/historic', to: 'pages#historic', defaults: { format: 'html' }

  get '/dashboard_admins', to: 'pages#dashboard_admins', as: :dashboard_admins
  get '/dashboard_admins/students', to: 'pages#admin_students', defaults: { format: 'html' }
  get '/dashboard_admins/statistics', to: 'pages#admin_statistics', defaults: { format: 'html' }

  # Defines the root path route ("/")
  # root "posts#index"
end
