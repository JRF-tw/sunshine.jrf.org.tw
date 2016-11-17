Rails.application.routes.draw do
  root to: 'base#index', only: [:show]
  get '/robots.txt', to: 'base#robots', defaults: { format: 'text' }
  get 'judges', to: 'profiles#judges', as: :judges
  get 'prosecutors', to: 'profiles#prosecutors', as: :prosecutors

  resources :searchs, path: 'search' do
    collection do
      get :judges
      get :prosecutors
    end
  end

  get 'about', to: 'base#about', as: :about
  resources :suits do
    resources :procedures
  end

  resources :profiles do
    resources :awards
    resources :punishments
  end

  resources :bulletins, only: [:index, :show]
end
