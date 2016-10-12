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
end
