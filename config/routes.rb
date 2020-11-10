Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'forecast#index'
      get 'backgrounds', to: 'image#show'
      post 'users', to: 'user#create'
    end
  end
end
