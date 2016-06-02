class Lawyers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_lawyer_exist_and_not_active, only: [:create]
  layout 'lawyer'

  def create
    resource = @lawyer 
    resource.send_confirmation_instructions
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def check_lawyer_exist_and_not_active
    if check_lawyer_params!
      redirect_to new_lawyer_registration_path 
      return
    end
    @lawyer = Lawyer.where(name: sign_up_params[:name], email: sign_up_params[:email]).first
    if !@lawyer
      set_flash_message :notice, :lawyer_not_found if is_flashing_format?
      redirect_to  new_lawyer_registration_path
      return 
    elsif @lawyer && @lawyer.confirmed?
      set_flash_message :notice, :lawyer_already_sign_up if is_flashing_format?
      redirect_to  new_lawyer_session_path
      return 
    end
  end

  def check_lawyer_params!
    set_flash_message(:notice, :name_blank) if sign_up_params[:name].blank?
    set_flash_message(:notice, :email_blank) if sign_up_params[:email].blank?
    sign_up_params[:name].blank? || sign_up_params[:email].blank?

  end

  def after_inactive_sign_up_path_for(resource)
    new_lawyer_session_path
  end

end
