Rails.application.routes.draw do
#API NAMESPACE
 namespace :api do
    namespace :v1 do
      get '/courses', to: 'courses#index'
      get '/courses/:course_id/enrollments', to: 'enrollments#index'
      post'/students', to: 'students#create'
      get '/students', to: 'students#index'

    end
  end

  #SESSIONS
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  get "admin_dashboard/index"

  #RESOURCES
  resources :students
  resources :mentors
  resources :enrollments
  resources :mentor_enrollment_assignments
  resources :lessons

  resources :coding_classes

  #get "/trimesters", to: "trimesters#index"
 # get "/trimesters/:id", to: "trimesters#show"

 #DASHBOARD
  get "/dashboard", to: "admin_dashboard#index"
  get '/dashboard/:id', to: 'admin_dashboard#show'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :submissions, only: [:index]  # fuera del bloque de courses

  resources :courses, only: [:index, :show, :edit, :update, :destroy, :new  ,:create]do
  resources :submissions, only: [:new, :create, :edit, :update, :destroy]
end
 resources :trimesters, only: [:index, :show, :new, :create, :edit, :update]


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
 