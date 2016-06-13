class Bystanders::RegistrationsController < Devise::RegistrationsController
  include CrudConcern

  before_action :configure_permitted_parameters, if: :devise_controller?

  def update
    bystander = current_bystander
    context = Bystander::ChangeEmailContext.new(bystander)
    prev_unconfirmed_email = bystander.unconfirmed_email if bystander.respond_to?(:unconfirmed_email)
    
    if context.perform(params)
      set_flash_message :notice, :update_needs_confirmation
      sign_in :bystander, bystander, bypass: true
      respond_with bystander, location: after_update_path_for(bystander)
    else
      clean_up_passwords resource
      flash.now[:error] = context.error_messages.join(", ")
      render :edit
    end
  end

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
  
end
