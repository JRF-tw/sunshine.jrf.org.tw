class CourtObservers::PasswordsController < Devise::PasswordsController
  layout 'observer'

  include CrudConcern
  prepend_before_action :require_no_authentication, except: [:edit, :update, :send_reset_password_mail]
  before_action :check_observer_confirmed, only: [:create]
  before_action :check_same_observer, only: [:edit, :update]

  def new
    set_meta
    super
  end

  def edit
    self.resource = resource_class.new
    set_minimum_password_length
    resource.reset_password_token = params[:reset_password_token]
    set_meta
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        sign_in(resource_name, resource, bypass: true)
        set_flash_message(:notice, flash_message)
      else
        set_flash_message(:notice, :updated_not_active)
      end
      respond_with resource, location: after_resetting_password_path
    else
      set_minimum_password_length
      @court_observer_by_token = resource
      respond_with resource
    end
  end

  def send_reset_password_mail
    context = CourtObserver::SendSetPasswordEmailContext.new(current_court_observer)
    context.perform
    redirect_as_success(court_observer_profile_path, "觀察者 - #{current_court_observer.name} 重設密碼信件已寄出")
  end

  protected

  def check_observer_confirmed
    @observer = CourtObserver.find_by_email(params[:court_observer][:email])
    if @observer && !@observer.confirmed?
      flash[:error] = '此帳號尚未驗證'
      self.resource = resource_class.new
      render 'new'
    end
  end

  def check_same_observer
    token = params[:reset_password_token] || params[:court_observer][:reset_password_token]
    @court_observer_by_token = CourtObserver.with_reset_password_token(token)
    if @court_observer_by_token.nil?
      redirect_as_fail(invalid_edit_path, '無效的驗證連結')
    elsif current_court_observer && current_court_observer != @court_observer_by_token
      redirect_as_fail(invalid_edit_path, '你僅能修改本人的帳號')
    end
  end

  def invalid_edit_path
    current_court_observer ? court_observer_profile_path : new_court_observer_session_path
  end

  def after_resetting_password_path
    court_observer_root_path
  end

end
