class Lawyers::ConfirmationsController < Devise::ConfirmationsController
  include CrudConcern
  layout 'lawyer'

  before_action :redirect_new_to_sign_in, only: [:new]
  before_action :find_lawyer_by_token

  def show
    if params[:confirmation_token].present?
      @original_token = params[:confirmation_token]
    elsif params[resource_name].try(:[], :confirmation_token).present?
      @original_token = params[resource_name][:confirmation_token]
    end

    if @lawyer.nil? or @lawyer.confirmed?
      redirect_to new_lawyer_session_path
      return
    end
  end

  def confirm
    @original_token = params[resource_name].try(:[], :confirmation_token)
    # use in view
    context = Lawyer::ConfirmContext.new(params)
    if context.perform
      set_flash_message :notice, :confirmed
      redirect_to new_lawyer_session_path
    else
      flash.now[:error] = context.error_messages.join(", ") if context.error_messages
      render :action => 'show'
    end
  end

  protected

  def find_lawyer_by_token
    @lawyer = Lawyer.find_by_confirmation_token(params[:confirmation_token] || params[:lawyer][:confirmation_token])
  end

  def redirect_new_to_sign_in
    redirect_to new_lawyer_session_path
  end


end
