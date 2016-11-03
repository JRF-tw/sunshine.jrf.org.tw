Rails.application.routes.draw do
  namespace :parties, path: "/party", as: "party" do
    root to: "stories#index"
    resource :profile, only: [:show, :edit, :update]
    resource :appeal, only: [:new]
    resource :email, only: [:edit, :update] do
      collection do
        post :resend_confirmation_mail
      end
    end
    resource :phone, only: [:new, :create, :edit, :update] do
      collection do
        get :verify
        put :verifing
        put :resend
      end
    end
    resource :score do
      resources :schedules, only: [:new, :create, :edit, :update] do
        collection do
          get :rule
          get :input_info
          post :check_info
          get :input_date
          post :check_date
          get :input_judge
          post :check_judge
        end
      end
      resources :verdicts, only: [:new, :create, :edit, :update] do
        collection do
          get :rule
          get :thanks_scored
          get :input_info
          post :check_info
        end
      end
    end
    resources :stories, only: [:show] do
      member do
        resource :subscribe, only: [] do
          collection do
            post :toggle
            get  :destroy
          end
        end
      end
    end
  end
end
