Rails
  .application
  .routes
  .draw do
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    # root "articles#index"

    namespace :api do
      namespace :v1 do
        resources :landlords, only: %i[index show update destroy] do
          collection { post 'signup', to: 'landlords#create' }
        end
      end
    end
  end
