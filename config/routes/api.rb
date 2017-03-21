Rails.application.routes.draw do
  namespace :api, defaults: { format: "json" } do
    resources :profiles, only: [:show, :index]
    resources :courts, only: [:index, :show]
    get "judges", to: "profiles#judges", as: :judges
    get "prosecutors", to: "profiles#prosecutors", as: :prosecutors
  end

  namespace :api, path: '' do
    constraints(host: /api/) do
      get '/:id/verdict', to: "verdicts#show", constraints: { id: /\w{3}-\d{2,3}-.+-\d+/ }, as: 'verdict'
      get ':court_code/:id', to: "stories#show", constraints: { court_code: /\w{3}/, id: /.+-\d{2,3}-.+-\d+/ }, as: 'story'
      get '/search/stories', to: "stories#index", as: 'stories'
    end
  end
end
