Rails.application.routes.draw do
  namespace :admin do
    root to: 'profiles#index'
    resources :profiles do
      resources :educations
      resources :careers
      resources :licenses
      resources :awards
      resources :punishments
      resources :reviews
      resources :articles
    end
    resources :suits do
      resources :procedures
    end
    get '/courts/edit_weight', to: 'courts#edit_weight', as: 'courts_edit_weight'
    put '/courts/:id/update_weight', to: 'courts#update_weight', as: 'court_update_weight'
    resources :courts
    resources :prosecutors_offices
    resources :judgments
    resources :banners
    resources :bulletins
    resources :suit_banners
    resources :users
    resources :stories
    resources :schedules
    resources :judges do
      member do
        post :set_to_prosecutor
      end
    end
    resources :prosecutors do
      member do
        post :set_to_judge
      end
    end
    resources :lawyers do
      member do
        post :send_reset_password_mail
      end
    end
    resources :verdicts do
      member do
        get :download_file
      end
    end
    resources :observers, only: [:show, :index]
    resources :parties do
      member do
        put :set_to_imposter
        get :stories
      end
    end
    resources :scores, only: [:index] do
      member do
        get :schedule
        get :verdict
      end
    end
    resources :crawler_histories, only: [:index] do
      resources :crawler_logs, only: [:show] do
        collection do
          get :pie_chart
        end
      end
      collection do
        get :status
        get :highest_judges
      end
    end
  end
end
