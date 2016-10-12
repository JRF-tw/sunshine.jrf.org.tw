require "sidekiq/web"
require "sidetiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  namespace :admin do
    root to: "profiles#index"
    resources :courts
    resources :profiles do
      resources :educations
      resources :careers
      resources :licenses
      resources :awards
      resources :punishments
      resources :reviews
      resources :articles
    end
    resources :suits do
      resources :procedures
    end
    resources :courts, only: [] do
      collection do
        get :edit_weight
      end
      member do
        put :update_weight
      end
    end
    resources :courts
    resources :judgments
    resources :banners
    resources :suit_banners
    resources :users
    resources :stories
    resources :schedules
    resources :judges
    resources :lawyers do
      member do
        post :send_reset_password_mail
      end
    end
    resources :verdicts do
      member do
        get :download_file
      end
    end
    resources :observers, only: [:show, :index]
    resources :parties do
      member do
        put :set_to_imposter
        get :stories
      end
    end
  end
end
