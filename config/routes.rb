require 'sidekiq/web'
Rails.application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users
  devise_for :party, controllers: { registrations: 'party/registrations', sessions: 'party/sessions', passwords: 'party/passwords', confirmations: 'party/confirmations' }
  devise_for :bystander, controllers: { registrations: 'bystander/registrations', sessions: 'bystander/sessions', passwords: 'bystander/passwords', confirmations: 'bystander/confirmations'}
  devise_for :lawyer, controllers: { registrations: 'lawyer/registrations', sessions: 'lawyer/sessions', passwords: 'lawyer/passwords', confirmations: 'lawyer/confirmations'}

  # custom devise scope
  devise_scope :lawyer do
    patch '/lawyer/confirm', to: 'lawyer/confirmations#confirm', as: :lawyer_confirm
    post '/lawyer/password/send_reset_password_mail', to: 'lawyer/passwords#send_reset_password_mail'
  end

  devise_scope :bystander do
    post '/bystander/password/send_reset_password_mail', to: 'bystander/passwords#send_reset_password_mail'
  end

  devise_scope :party do
    post "/party/password/send_reset_password_sms", to:"party/passwords#send_reset_password_sms"
  end

  # f2e
  root to: "base#index", only: [:show]
  get '/who-are-you', to: "base#who_are_you"
  get '/robots.txt', to: "base#robots", defaults: { format: "text" }
  get "judges", to: "profiles#judges", as: :judges
  get "prosecutors", to: "profiles#prosecutors", as: :prosecutors

  namespace :bystander do
    resource :profile, only: [:show, :edit, :update]
    resource :email, only: [:edit]
    resources :scores, only: [:index, :edit]
    resource :score do
      get "chose-type", to: "scores#chose_type"
      resource :schedules, only: [:new] do
        collection do
          post :verify
        end
      end
      resource :verdicts, only: [:new] do
        collection do
          post :verify
        end
      end
    end
    resources :stories, only: [] do
      member do
        resource :subscribe, only: [:create]
      end
    end
  end

  namespace :lawyer do
    resource :appeal, only: [:new]
    resource :profile, only: [:show, :edit, :update]
    resource :email, only: [:edit]
    resources :scores, only: [:index, :edit]
    resource :score do
      get "chose-type", to: "scores#chose_type"
      resource :schedules, only: [:new] do
        collection do
          post :verify
        end
      end
      resource :verdicts, only: [:new] do
        collection do
          post :verify
        end
      end
    end
    resources :stories, only: [] do
      member do
        resource :subscribe, only: [:create]
      end
    end
  end

  namespace :party do
    resource :profile, only: [:show, :edit, :update]
    resource :appeal, only: [:new]
    resource :email, only: [:edit, :update]
    resource :phone, only: [:new, :create, :edit, :update] do
      collection do
        get :verify
        put :verifing
        put :resend
      end
    end
    resources :scores, only: [:index, :edit]
    resource :score do
      get "chose-type", to: "scores#chose_type"
      resource :schedules, only: [:new] do
        collection do
          post :verify
        end
      end
      resource :verdicts, only: [:new] do
        collection do
          post :verify
        end
      end
    end
    resources :stories, only: [] do
      member do
        resource :subscribe, only: [:create]
      end
    end
  end

  resources :scores, only: [:index]
  resources :judges, only: [:show]

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
