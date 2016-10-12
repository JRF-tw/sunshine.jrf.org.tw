Rails.application.routes.draw do
  get "/who-are-you", to: "base#who_are_you"
  get "/score-intro", to: "base#score_intro"

  resources :scores, only: [:index]
  resources :judges, only: [:show]
end
