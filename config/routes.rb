Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'gardens/show'
  get 'households/choose', to: 'households#choose', as: :choose_household

  # Defines the root path route ("/")
  # root "posts#index"

  resources :tasks, only: [:index, :new, :create, :edit, :update, :destroy]

  resources :households, only: [:show, :new, :create, :edit, :update, :destroy] do
    get 'calendar', to: 'calendars#show'
    member do
      post :timetable
      get 'chores'
      post 'send_request' # To send a request to join an existing household
    end
    collection do
      get :search_users
      get 'choose' # For the user to choose between creating or joining
    end
  end




  resources :users, only: [:index, :show] do
    get 'garden', to: 'gardens#show'

    member do

    end
  end

  get 'gardens/water', to: 'gardens#water', as: :water

  resources :submissions, only: [:new, :create, :edit, :update,]







  # Routes for users
  # resources :users, only: [:index, :show, :edit, :update] do
  #   resources :submissions, only: [:index, :show, :create, :edit, :update, :destroy]
  # end

  # # Routes for households
  # resources :households, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
  #   resources :tasks, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  # end

  # # Direct routes for tasks if needed outside of households
  # resources :tasks, only: [:destroy]

  # # Direct routes for submissions if needed outside of users
  # resources :submissions, only: [:destroy]
end
