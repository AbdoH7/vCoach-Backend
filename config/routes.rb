Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users, except: [:update, :destroy]
      post '/users/login', to: 'users#login'
      resources :invites, only: [:create, :index, :show]
    end
  end
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
