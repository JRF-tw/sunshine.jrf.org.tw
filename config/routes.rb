require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users
  
  root to: "base#index"
  get '/robots.txt', to: "base#robots", defaults: { format: "text" }

  namespace :admin do
    root to: "profiles#index"
    resources :profiles do
      resources :educations
      resources :careers
      resources :licenses
      resources :awards
      resources :punishments
      resources :reviews
    end
    resources :users
  end
end
