# frozen_string_literal: true

Rails.application.routes.draw do
  resources :regions do
    resources :theatres do
      resources :halls do
        resources :shows, only: %i[index show]
      end
    end
  end

  resources :shows do
    resources :bookings, only: %i[index show create destroy update]
  end

  resources :users

  resources :movies

  resources :timings
end
