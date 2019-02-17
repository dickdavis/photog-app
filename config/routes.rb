# frozen_string_literal: true

##
# = routes.rb
# Author::    Mushaka Solutions
# Copyright:: Copyright 2018-2019 Mushaka Solutions Inc.
# License::   GNU Public License 3
#
# Routes for the application
Rails.application.routes.draw do
  # Clearance routes to constrains signed in users to the dashboard
  constraints Clearance::Constraints::SignedIn.new do
    root to: 'dashboard#show', as: :signed_in_root
  end

  # Clearance routes to constrain signed out users to the public pages
  constraints Clearance::Constraints::SignedOut.new do
    root to: 'public#index'
  end

  # Clearance routes for users and passwords for password resets
  resources :users, controller: 'users', only: [:create] do
    resource :password, controller: 'clearance/passwords',
                        only: %i[create edit update]
  end

  # Clearance routes for passwords
  resources :passwords, controller: 'clearance/passwords', only: %i[create new]

  # Clearance routes for login
  resource :session, controller: 'sessions', only: %i[create new]

  # Application route for dashboard
  get 'dashboard', to: 'dashboard#show', as: :dashboard

  # Application routes for bookings
  resources :bookings, only: %i[index show new create edit update destroy]

  # Application routes for clients
  resources :clients, only: %i[index show new create edit update destroy]

  # Application routes for package groups
  resources :package_groups, only: %i[index new create edit update destroy] do
    # Application routes for packages
    resources :packages, only: %i[new create show edit update destroy]
  end

  # Application routes for booking requests
  resources :booking_requests, only: %i[new show create edit update destroy] do
    member do
      post 'confirm'
    end
  end

  # Application route for public pricing
  get 'pricing', to: 'public#pricing', as: :pricing

  # The root application route
  root 'public#index'
end
