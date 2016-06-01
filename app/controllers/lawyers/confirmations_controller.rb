class Lawyers::ConfirmationsController < Devise::ConfirmationsController
  layout 'lawyer'

  skip_before_filter :authenticate_lawyer!
  before_action :redirect_new_to_sign_in, only: [:new]

  def show
    if params[:confirmation_token].present?
      @original_token = params[:confirmation_token]
    elsif params[resource_name].try(:[], :confirmation_token).present?
      @original_token = params[resource_name][:confirmation_token]
    end
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token])
    # self.resource = resource_class.find_by_confirmation_token Devise.token_generator.
    #   digest(self, :confirmation_token, @original_token)
    if resource.nil? or resource.confirmed?
      redirect_to new_lawyer_session_path
      return
    end
  end

  def confirm
    @original_token = params[resource_name].try(:[], :confirmation_token)
    # digested_token = Devise.token_generator.digest(self, :confirmation_token, @original_token)
    self.resource = resource_class.find_by_confirmation_token! @original_token
    resource.assign_attributes(permitted_params) unless params[resource_name].nil?

    if resource.valid? && resource.password_match?
      self.resource.confirm!
      set_flash_message :notice, :confirmed
      sign_in_and_redirect resource_name, resource
    else
      render :action => 'show'
    end
  end

  protected

  def permitted_params
    params.require(resource_name).permit(:confirmation_token, :password, :password_confirmation)
  end

  def redirect_new_to_sign_in
    redirect_to new_lawyer_session_path
  end


end
