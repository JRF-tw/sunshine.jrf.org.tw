class Party::RegistrationsController < Devise::RegistrationsController
  layout 'party'
  before_action :configure_permitted_parameters, if: :devise_controller?

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.save
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
      flash[:notice] = resource.errors.full_messages
      render "new"
    end
  end

  protected

  def after_sign_in_path_for(_resource)
    party_profile_path
  end

  def after_sign_up_path_for(_resource)
    new_party_phone_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:identify_number, :name]
  end
end
