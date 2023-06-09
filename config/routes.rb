Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users, except: [:update, :destroy]
      post '/users/login', to: 'users#login'
      resources :invites, only: [:create, :index, :show]
      resources :doctor_patient_assignments, only: [:create, :index]
      post '/:doctor_patient_assignments/remove', to: 'doctor_patient_assignments#remove'
    end
  end
  
   ###This need to be removed when we configure an actual smtp server and mount letter oppener for dev mode only###
   mount LetterOpenerWeb::Engine, at: "/letter_opener"
  
   #   if Rails.env.development?
   #     mount LetterOpenerWeb::Engine, at: "/letter_opener"
   #   end

end
