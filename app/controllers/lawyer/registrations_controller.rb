class Lawyer::RegistrationsController < Devise::RegistrationsController
  include CrudConcern
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout 'lawyer'

  def create
    context = Lawyer::RegisterContext.new(params)
    @lawyer = context.perform
    if @lawyer
      set_flash_message :notice, :"signed_up_but_#{@lawyer.inactive_message}" if is_flashing_format?
      respond_with resource, location: after_inactive_sign_up_path_for(resource)
    elsif context.errors[:lawyer_exist]
      redirect_as_fail(new_lawyer_session_path, context.error_messages.join(", "))
    else
      redirect_as_fail(new_lawyer_registration_path, context.error_messages.join(", "))
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def after_inactive_sign_up_path_for(resource)
    new_lawyer_session_path
  end

end