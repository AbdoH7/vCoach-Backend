Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users, except: [:destroy]
      post '/users/login', to: 'users#login'
      resources :invites, only: [:create, :index, :show]
      resources :doctor_patient_assignments, only: [:create, :index]
      post '/:doctor_patient_assignments/remove', to: 'doctor_patient_assignments#remove'
      resources :exercises, only: [:index]
      resources :assignments, only: [:index, :create, :update, :show, :destroy]
      put '/assignments/:id/doctor_update', to: 'assignments#doctor_update'
    end
  end
  
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
