class Parties::RegistrationsController < Devise::RegistrationsController
  layout "party"
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_registration, only: [:create]
  # POST /resource

  def check_identify_number
    context = Party::IdentifyNumberCheckContext.new(params)
    if @party = context.perform
      @checked = true
      flash.clear
    else
      build_resource(sign_up_params)
      flash[:error] = context.error_messages.join(", ")
    end
    render :new
  end

  protected

  def check_registration
    context = Party::RegisterCheckContext.new(params)
    unless context.perform
      build_resource(sign_up_params)
      flash[:error] = context.error_messages.join(", ")
      @checked = true
      render "new"
    end
  end

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
