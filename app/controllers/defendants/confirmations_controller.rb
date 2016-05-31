class Defendants::ConfirmationsController < Devise::ConfirmationsController
  before_action :redirect_new_to_sign_in, only: [:new]


  protected

  def redirect_new_to_sign_in
    redirect_to new_defendant_session_path
  end
end
