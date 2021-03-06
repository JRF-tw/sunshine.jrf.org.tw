Rails.application.routes.draw do
  namespace :api, defaults: { format: "json" } do
    resources :courts, only: [:index, :show]
    get "judges", to: "profiles#judges", as: :judges
    get "prosecutors", to: "profiles#prosecutors", as: :prosecutors
    get '/' => redirect('https://5fpro.github.io/raml-api-console/?raml=https://5fpro.github.io/jrf-sunny/api/index.raml')
  end

  namespace :api, path: '', defaults: { format: "json" } do
    constraints(host: /api/) do
      root to: "base#index"
      resources :courts, only: [:index, :show]
      get '/search/stories', to: "stories#index", as: 'stories'
      get ':court_code/:id', to: "stories#show", constraints: { court_code: /\w{3}/, id: /.*-\d{2,3}-.+-\d+/ }, as: 'story'
      get ':court_code/:id/verdict', to: "verdicts#show", constraints: { court_code: /\w{3}/, id: /.*-\d{2,3}-.+-\d+/ }, as: 'verdict'
      get ':court_code/:id/rules', to: "rules#index", constraints: { court_code: /\w{3}/, id: /.*-\d{2,3}-.+-\d+/ }, as: 'rules'
      get ':court_code/:id/schedules', to: "schedules#index", constraints: { court_code: /\w{3}/, id: /.*-\d{2,3}-.+-\d+/ }, as: 'schedules'
    end
  end
end
