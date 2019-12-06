Rails.application.routes.draw do

  resources :regions do
    resources :theatres do
      resources :halls do
        resources :shows, only: [:index, :show]
      end 
    end
  end

  resources :shows do
    resources :bookings, only: [:index, :show, :create, :destroy, :update]
  end
  
  resources :users

  resources :movies

  resources :timings

end
