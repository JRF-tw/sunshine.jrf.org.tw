require 'sidekiq/web'
Rails.application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users

  devise_for :defendants, controllers: { registrations: 'defendants/registrations', sessions: 'defendants/sessions', passwords: 'defendants/passwords' }
  devise_for :bystanders, controllers: { registrations: 'bystander/registrations', sessions: 'bystander/sessions', passwords: 'bystander/passwords', confirmations: 'bystander/confirmations'}
  devise_for :lawyers, controllers: { registrations: 'lawyers/registrations', sessions: 'lawyers/sessions', passwords: 'lawyers/passwords', confirmations: 'lawyers/confirmations'}
  devise_scope :lawyer do
    patch '/lawyers/confirm', to: 'lawyers/confirmations#confirm', as: :lawyers_confirm
  end

  root to: "base#index", only: [:show]
  get '/robots.txt', to: "base#robots", defaults: { format: "text" }

  get "judges", to: "profiles#judges", as: :judges
  get "prosecutors", to: "profiles#prosecutors", as: :prosecutors

  resources :searchs, path: "search" do
    collection do
      get :judges
      get :prosecutors
    end
  end
  get "about", to: "base#about", as: :about
  resources :suits do
    resources :procedures
  end
  resources :profiles do
    resources :awards
    resources :punishments
  end

  resources :bystanders

  namespace :lawyers do
    root to: "base#index"
    get "profile", to: "base#profile"
    get "edit-profile", to: "base#edit_profile"
    post "update_profile", to: "base#update_profile"
  end

  namespace :defendants do
    root to: "base#index"
  end

  namespace :api, defaults: { format: 'json' } do
    resources :profiles, only: [:show, :index]
    get "judges", to: "profiles#judges", as: :judges
    get "prosecutors", to: "profiles#prosecutors", as: :prosecutors
  end

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
        post :manual_confirm
      end
    end
    resources :verdicts do
      member do
        get :download_file
      end
    end
    resources :bystanders, only: [:index, :show]
    resources :defendants, only: [:index, :show]
  end
end
