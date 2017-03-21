Rails.application.routes.draw do
  constraints(host: /search/)  do
    get '/', to: 'stories#index', as: 'stories'
    get ':court_code/:id', to: "stories#show", constraints: { court_code: /\w{3}/, id: /.+-\d{2,3}-.+-\d+/ }, as: 'story'
  end
end
