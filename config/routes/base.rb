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
  resources :judges, only: [:show]
  resources :bulletins, only: [:index, :show]
  resources :stories, only: [:index]
  get ':court_code/:id', to: "stories#show", constraints: { court_code: /\w{3}/, id: /\d{2,3}-.+-\d+/ }
end
