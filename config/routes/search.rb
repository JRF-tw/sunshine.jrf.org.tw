Rails.application.routes.draw do
  namespace :search do
    get '/', to: 'stories#index', as: 'stories'
    get ':court_code/:id', to: "stories#show", constraints: { court_code: /\w{3}/, id: /.*-\d{2,3}-.+-\d+/ }, as: 'story'
    get ':court_code/:id/schedules', to: 'schedules#index', constraints: { court_code: /\w{3}/, id: /.*-\d{2,3}-.+-\d+/ }, as: 'schedules'
    get ':court_code/:id/verdict', to: "verdicts#show", constraints: { court_code: /\w{3}/, id: /.*-\d{2,3}-.+-\d+/ }, as: 'verdict'
  end
end
