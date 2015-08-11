require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users
  
  root to: "base#index"
  get '/robots.txt', to: "base#robots", defaults: { format: "text" }

  resources :judges, :to => "profiles#judges"
  resources :prosecutors, :to => "profiles#prosecutors"
  resources :searchs, path: "search" do
    collection do
      get :judges
      get :prosecutors
      get :suits
    end
  end
  resources :about, :to => "base#about"
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
    resources :courts
    resources :judgments
    resources :suits
    resources :users
  end
end
