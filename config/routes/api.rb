Rails.application.routes.draw do
  namespace :api, defaults: { format: "json" } do
    resources :profiles, only: [:show, :index]
    get "judges", to: "profiles#judges", as: :judges
    get "prosecutors", to: "profiles#prosecutors", as: :prosecutors
  end
end
