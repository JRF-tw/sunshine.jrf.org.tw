class Bystanders::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_update_email_different, only: [:update]
  before_action :check_update_email_not_use, only: [:update]

  protected

  def after_inactive_sign_up_path_for(resource)
    new_session_path(:bystander)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def after_update_path_for(resource)
    bystanders_root_path
  end

  def check_update_email_different
    if account_update_params["email"] == current_bystander.email
      set_flash_message :notice, :email_the_same
      render :action =>"edit"
    end
  end

  def check_update_email_not_use
    if Bystander.pluck(:unconfirmed_email).include?(account_update_params["email"])
      set_flash_message :notice, :email_conflict
      render :action =>"edit"
    end
  end
end
