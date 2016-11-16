class Parties::RegistrationsController < Devise::RegistrationsController
  layout 'party'
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_registration, only: [:create]
  # POST /resource

  def new
    # meta
    set_meta(
      title: '當事人註冊頁',
      description: '當事人註冊頁',
      keywords: '當事人註冊頁'
    )
    super
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    alert_to_slack!(resource)
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
      Party::DeleteUnconfirmContext.perform(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def check_identify_number
    context = Party::IdentifyNumberCheckContext.new(params)
    if @party = context.perform
      @checked = true
      flash.clear
    else
      build_resource(sign_up_params)
      flash[:error] = context.error_messages.join(', ')
    end
    render :new
  end

  protected

  def check_registration
    context = Party::RegisterCheckContext.new(params)
    unless context.perform
      build_resource(sign_up_params)
      flash[:error] = context.error_messages.join(', ')
      @checked = true
      render 'new'
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

  def alert_to_slack!(resource)
    SlackService.notify_user_activity_alert("新當事人註冊 : #{SlackService.render_link(admin_party_url(resource, host: Setting.host), resource.name)}  已經申請註冊")
  end
end
