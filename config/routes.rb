require 'sidekiq/web'
Rails.application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users


  devise_for :defendants, controllers: { registrations: 'defendants/registrations', sessions: 'defendants/sessions', passwords: 'defendants/passwords', confirmations: 'defendants/confirmations' }
  devise_for :bystanders, controllers: { registrations: 'bystanders/registrations', sessions: 'bystanders/sessions', passwords: 'bystanders/passwords', confirmations: 'bystanders/confirmations'}
  devise_for :lawyers, controllers: { registrations: 'lawyers/registrations', sessions: 'lawyers/sessions', passwords: 'lawyers/passwords', confirmations: 'lawyers/confirmations'}
  devise_scope :lawyer do
    patch '/lawyers/confirm', to: 'lawyers/confirmations#confirm', as: :lawyers_confirm
    post '/lawyers/password/send_reset_password_mail', to: 'lawyers/passwords#send_reset_password_mail'
  end

  devise_scope :bystander do
    post '/bystanders/password/send_reset_password_mail', to: 'bystanders/passwords#send_reset_password_mail'
  end

  devise_scope :defendant do
    post "/defendants/password/send_reset_password_sms", to:"defendants/passwords#send_reset_password_sms"
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

  namespace :bystanders do
    root to: "base#index"
    get "profile", to: "base#profile"
  end

  namespace :lawyers do
    root to: "base#index"
    get "profile", to: "base#profile"
    get "edit-profile", to: "base#edit_profile"
    post "update_profile", to: "base#update_profile"
    post "send_reset_password_mail", to: "base#send_reset_password_mail"
  end

  namespace :defendants do
    root to: "base#index"
    get "profile", to: "base#profile"
    get "edit-email", to: "base#edit_email"
    put "update-email", to: "base#update_email"
    resource :phone, only: [:new, :create, :edit, :update] do
      collection do
        get :verify
        put :verifing
        put :resend
      end
    end
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
        post :send_reset_password_mail
      end
    end
    resources :verdicts do
      member do
        get :download_file
      end
    end
    resources :bystanders do
      collection do
        get :download_file
      end
    end
    resources :defendants, only: [:index, :show]
  end
end
