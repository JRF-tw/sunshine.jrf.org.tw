require 'sidekiq/web'
Rails.application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users


  devise_for :parties, controllers: { registrations: 'parties/registrations', sessions: 'parties/sessions', passwords: 'parties/passwords', confirmations: 'parties/confirmations' }
  devise_for :bystanders, controllers: { registrations: 'bystanders/registrations', sessions: 'bystanders/sessions', passwords: 'bystanders/passwords', confirmations: 'bystanders/confirmations'}
  devise_for :lawyer, controllers: { registrations: 'lawyer/registrations', sessions: 'lawyer/sessions', passwords: 'lawyer/passwords', confirmations: 'lawyer/confirmations'}
  devise_scope :lawyer do
    patch '/lawyer/confirm', to: 'lawyer/confirmations#confirm', as: :lawyer_confirm
    post '/lawyer/password/send_reset_password_mail', to: 'lawyer/passwords#send_reset_password_mail'
  end

  devise_scope :bystander do
    post '/bystanders/password/send_reset_password_mail', to: 'bystanders/passwords#send_reset_password_mail'
  end

  devise_scope :party do
    post "/parties/password/send_reset_password_sms", to:"parties/passwords#send_reset_password_sms"
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

  namespace :lawyer do
    root to: "base#index"
    get "profile", to: "base#profile"
    get "edit-profile", to: "base#edit_profile"
    post "update_profile", to: "base#update_profile"
  end

  namespace :parties do
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
    resources :parties do
      member do
        put :set_to_imposter
      end
    end

  end
end
