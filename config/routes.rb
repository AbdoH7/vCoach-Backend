Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users, except: [:update, :destroy]
      post '/users/login', to: 'users#login'
    end
  end
  
end