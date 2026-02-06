# config/routes.rb
Rails.application.routes.draw do
  root 'sessions#new'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/dashboard', to: 'dashboard#index'
  
  resources :students
  resources :teachers
  resources :courses
  resources :enrollments do
    collection do
      get :my_courses
    end
  end
end