Rails.application.routes.draw do
  root to: "base#index", only: [:show]
  get "/who-are-you", to: "base#who_are_you"
  get "/score-intro", to: "base#score_intro"
  get "/robots.txt", to: "base#robots", defaults: { format: "text" }
  get "judges", to: "profiles#judges", as: :judges
  get "prosecutors", to: "profiles#prosecutors", as: :prosecutors

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
end
