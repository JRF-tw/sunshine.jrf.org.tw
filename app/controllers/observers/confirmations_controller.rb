class Observers::ConfirmationsController < Devise::ConfirmationsController
  layout "observer"
  include CrudConcern

  before_action :check_observer, only: [:show]
  before_action :check_first_time_confirm_email, only: [:show]
  before_action :redirect_new_to_sign_in, only: [:new]

  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?
    if resource.errors.empty?
      if @first_time_confirm
        set_flash_message(:notice, :confirmed) if is_flashing_format?
        sign_in(resource_name, resource)
        respond_with_navigational(resource) { redirect_to observer_root_path }
      else
        set_flash_message(:notice, :confirmed) if is_flashing_format?
        respond_with_navigational(resource) { redirect_to new_court_observer_session_path }
      end
    else
      set_flash_message(:notice, :already_confirmed) if resource.unconfirmed_email.nil? && resource.confirmation_token == params[:confirmation_token]
      respond_with_navigational(resource.errors, status: :unprocessable_entity) { redirect_to new_court_observer_session_path }
    end
  end

  protected

  def redirect_new_to_sign_in
    redirect_to new_court_observer_session_path
  end

  def after_resending_confirmation_instructions_path_for(_resource_name)
    edit_court_observer_registration_path
  end

  def check_observer
    @observer_by_token = CourtObserver.find_by_confirmation_token(params[:confirmation_token])
    redirect_as_fail(observer_root_path, "你僅能修改本人的帳號") if current_court_observer && current_court_observer != @observer_by_token
  end

  def check_first_time_confirm_email
    @first_time_confirm = @observer_by_token && @observer_by_token.unconfirmed_email.nil?
  end
end
