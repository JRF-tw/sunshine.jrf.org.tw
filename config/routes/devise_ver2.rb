Rails.application.routes.draw do
  devise_for :parties, path: "party", controllers: { registrations: "parties/registrations", sessions: "parties/sessions", passwords: "parties/passwords", confirmations: "parties/confirmations" }
  devise_for :court_observers, path: "observer", controllers: { registrations: "court_observers/registrations", sessions: "court_observers/sessions", passwords: "court_observers/passwords", confirmations: "court_observers/confirmations" }
  devise_for :lawyers, path: "lawyer", controllers: { registrations: "lawyers/registrations", sessions: "lawyers/sessions", passwords: "lawyers/passwords", confirmations: "lawyers/confirmations" }

  # custom devise scope
  devise_scope :lawyer do
    post "/lawyer/password/send_reset_password_mail", to: "lawyers/passwords#send_reset_password_mail"
  end

  devise_scope :court_observer do
    post "/observer/password/send_reset_password_mail", to: "court_observers/passwords#send_reset_password_mail"
  end

  devise_scope :party do
    post "/party/password/send_reset_password_sms", to: "parties/passwords#send_reset_password_sms"
    post "/party/registrations/check_identify_number", to: "parties/registrations#check_identify_number"
  end
end
