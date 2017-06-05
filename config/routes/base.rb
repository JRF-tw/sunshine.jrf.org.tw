require 'sidekiq/web'
require 'sidetiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get '/who-are-you', to: 'base#who_are_you'
  get '/score-intro', to: 'base#score_intro'
  get '/tos', to: 'base#terms_of_service'
  get '/privacy', to: 'base#privacy'
  resources :scores, only: [:index]
  resources :judges, only: [:index, :show] do
    resources :awards, only: [:index]
    resources :punishments, only: [:index, :show]
    resources :reviews, only: [:index]
  end
  resources :prosecutors, only: [:index, :show] do
    resources :awards, only: [:index]
    resources :punishments, only: [:index, :show]
    resources :reviews, only: [:index]
  end
  resources :bulletins, only: [:index, :show]
end
