Rails.application.routes.draw do
  namespace :api, defaults: { format: "json" } do
    resources :profiles, only: [:show, :index]
    resources :courts, only: [:index, :show]
    get "judges", to: "profiles#judges", as: :judges
    get "prosecutors", to: "profiles#prosecutors", as: :prosecutors
    get '*unmatched_route', to: 'base#page_404'
  end
end
