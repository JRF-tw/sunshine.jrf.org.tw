class Lawyers::ConfirmationsController < Devise::ConfirmationsController
  include CrudConcern
  layout 'lawyer'

  before_action :redirect_new_to_sign_in, only: [:new]
  before_action :find_lawyer, expect: [:create]
  before_action :find_token, expect: [:create]

  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?
    if need_set_password?(resource)
      sign_in(resource_name, resource)
      reset_password_token = resource.set_reset_password_token
      set_flash_message(:notice, :need_set_password)
      redirect_to edit_password_path(resource, reset_password_token: reset_password_token)
    elsif resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_flashing_format?
      respond_with_navigational(resource) { redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity) { redirect_to new_lawyer_session_path }
    end
  end

  protected

  def find_lawyer
    @lawyer = Lawyer::FindByConfirmationTokenContext.new(params).perform
  end

  def find_token
    @original_token = params[:confirmation_token] || params[resource_name].try(:[], :confirmation_token)
  end

  def redirect_new_to_sign_in
    redirect_to new_lawyer_session_path
  end

  def after_resending_confirmation_instructions_path_for(_resource_name)
    lawyer_profile_path
  end

  def after_confirmation_path_for(resource_name, _resource)
    if signed_in?(resource_name)
      lawyer_root_path
    else
      new_session_path(resource_name)
    end
  end

  def need_set_password?(resource)
    !resource.encrypted_password.present?
  end

end
