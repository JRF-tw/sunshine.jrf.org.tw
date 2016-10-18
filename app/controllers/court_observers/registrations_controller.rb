class CourtObservers::RegistrationsController < Devise::RegistrationsController
  layout "observer"
  include CrudConcern

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_registration, only: [:create]

  def new
    # meta
    set_meta(
      title: "觀察者註冊頁",
      description: "觀察者註冊頁",
      keywords: "觀察者註冊頁"
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
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def update
    context = CourtObserver::ChangeEmailContext.new(current_court_observer)
    if context.perform(params)
      set_flash_message :notice, :update_needs_confirmation
      sign_in :court_observer, current_court_observer, bypass: true
      respond_with current_court_observer, location: after_update_path_for(current_court_observer)
    else
      clean_up_passwords resource
      flash.now[:error] = context.error_messages.join(", ")
      render :edit
    end
  end

  protected

  def check_registration
    build_resource(sign_up_params)
    context = CourtObserver::RegisterCheckContext.new(params)
    context.perform
    if context.errors[:observer_already_confirm] || context.errors[:observer_already_sign_up]
      flash[:error] = context.error_messages.join(", ")
      redirect_to new_court_observer_session_path
    elsif context.errors.any?
      flash[:error] = context.error_messages.join(", ")
      render "new"
    end
  end

  def after_inactive_sign_up_path_for(_resource)
    new_session_path(:court_observer)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def after_update_path_for(_resource)
    court_observer_profile_path
  end

  def alert_to_slack!(resource)
    SlackService.notify_user_activity_alert("新觀察者註冊 : #{SlackService.render_link(admin_observer_url(resource, host: Setting.host), resource.name)} 已經申請註冊")
  end
end
