Rails.application.routes.draw do
  root to: 'welcome#index'
  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'forecast#index'
      get 'backgrounds', to: 'image#show'
      post 'users', to: 'user#create'
      post 'sessions', to: 'sessions#create'
      post 'road_trip', to: 'road_trip#create'
    end
  end
end
