require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users
  
  root to: "base#index", only: [:show]
  get '/robots.txt', to: "base#robots", defaults: { format: "text" }

  get "judges", :to => "profiles#judges", :as => :judges
  get "prosecutors", :to => "profiles#prosecutors", :as => :prosecutors
  resources :searchs, path: "search" do
    collection do
      get :judges
      get :prosecutors
      get :suits
    end
  end
  get "about", :to => "base#about", :as => :about
  resources :suits do
    resources :procedures
  end
  resources :profiles do
    resources :awards
    resources :punishments
    resources :reviews
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
    resources :users
  end
end
