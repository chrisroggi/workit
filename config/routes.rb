Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [ :create ] do
    collection do
      post 'login'
      post 'update'
    end
  end

  resources :workouts, only: [ :show, :index, :create, :update ]

  resources :exercises, only: [ :show, :index, :create, :update ]

end
