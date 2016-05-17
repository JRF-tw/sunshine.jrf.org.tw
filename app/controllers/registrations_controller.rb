class RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(resource)
    case resource
    when Bystander 
      new_session_path(:bystander)
    else
      root_path
    end
  end

end
