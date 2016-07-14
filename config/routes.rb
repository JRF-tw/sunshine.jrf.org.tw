require "sidekiq/web"
require "sidetiq/web"
Rails.application.routes.draw do
  mount RedactorRails::Engine => "/redactor_rails"
  mount Sidekiq::Web => "/sidekiq"

  devise_for :users
  devise_for :party, controllers: { registrations: "parties/registrations", sessions: "parties/sessions", passwords: "parties/passwords", confirmations: "parties/confirmations" }
  devise_for :court_observer, path: "observer", controllers: { registrations: "observers/registrations", sessions: "observers/sessions", passwords: "observers/passwords", confirmations: "observers/confirmations" }
  devise_for :lawyer, controllers: { registrations: "lawyers/registrations", sessions: "lawyers/sessions", passwords: "lawyers/passwords", confirmations: "lawyers/confirmations" }

  # custom devise scope
  devise_scope :lawyer do
    post "/lawyer/password/send_reset_password_mail", to: "lawyers/passwords#send_reset_password_mail"
  end

  devise_scope :court_observer do
    post "/observer/password/send_reset_password_mail", to: "observers/passwords#send_reset_password_mail"
  end

  devise_scope :party do
    post "/party/password/send_reset_password_sms", to: "parties/passwords#send_reset_password_sms"
  end

  # f2e
  root to: "base#index", only: [:show]
  get "/who-are-you", to: "base#who_are_you"
  get "/score-intro", to: "base#score_intro"
  get "/robots.txt", to: "base#robots", defaults: { format: "text" }
  get "judges", to: "profiles#judges", as: :judges
  get "prosecutors", to: "profiles#prosecutors", as: :prosecutors

  namespace :observers, path: "/observer", as: "observer" do
    root to: "scores#index"
    resource :profile, only: [:show, :edit, :update]
    resource :email, only: [:edit, :update]
    resources :scores, only: [:edit, :show]
    resource :score do
      get "chose-type", to: "scores#chose_type"
      resource :schedules, only: [:new] do
        collection do
          get :rule
          post :verify
        end
      end
      resource :verdicts, only: [:new] do
        collection do
          get :rule
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

  namespace :lawyers, path: "/lawyer", as: "lawyer" do
    root to: "scores#index"
    resource :appeal, only: [:new]
    resource :profile, only: [:show, :edit, :update]
    resource :email, only: [:edit, :update]
    resources :scores, only: [:index, :edit, :show]
    resource :score do
      get "chose-type", to: "scores#chose_type"
      resource :schedules, only: [:new, :create] do
        collection do
          get :rule
          post :check_info
          post :check_date
          post :check_judge
          post :verify
        end
      end
      resource :verdicts, only: [:new] do
        collection do
          get :rule
          post :verify
        end
      end
    end
    resources :stories, only: [] do
      member do
        resource :subscribe, only: [:create, :destroy]
      end
    end
  end

  namespace :parties, path: "/party", as: "party" do
    root to: "scores#index"
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
    resources :scores, only: [:edit, :show]
    resource :score do
      get "chose-type", to: "scores#chose_type"
      resource :schedules, only: [:new] do
        collection do
          get :rule
          post :verify
        end
      end
      resource :verdicts, only: [:new] do
        collection do
          get :rule
          post :verify
        end
      end
    end
    resources :stories do
      member do
        resource :subscribe, only: [:create, :destroy]
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

  namespace :api, defaults: { format: "json" } do
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
    resources :observers, only: [:show, :index]
    resources :parties do
      member do
        put :set_to_imposter
      end
    end

  end
end
