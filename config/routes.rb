Rails
  .application
  .routes
  .draw do
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    # root "articles#index"

    namespace :api do
      namespace :v1 do
        resources :landlords, only: %i[index show update destroy]
        resources :renters, only: %i[index show update destroy]

        # registration end points
        post 'landlords/signup', to: 'landlords#create'
        post 'renters/signup', to: 'renters#create'

        # authentication end points
        scope '/auth' do
          post '/landlord', to: 'authentication#landlord_create'
          post '/renter', to: 'authentication#renter_create'
        end

        resources :properties, only: %i[index create show update destroy]
        resources :rentals, only: %i[index create show update destroy]
      end
    end
  end
