class Lawyers::ConfirmationsController < Devise::ConfirmationsController
  include CrudConcern
  layout 'lawyer'

  before_action :redirect_new_to_sign_in, only: [:new]
  before_action :find_lawyer
  before_action :find_token

  def show
    context = Lawyer::ShowSetPasswordContext.new(@lawyer)
    return redirect_as_fail(new_lawyer_session_path, context.error_messages.join(", ")) unless context.perform
  end

  def confirm
    context = Lawyer::ConfirmAndSetPasswordContext.new(params)
    if context.perform
      set_flash_message :notice, :confirmed
      redirect_to new_lawyer_session_path
    else
      flash.now[:error] = context.error_messages.join(", ") if context.error_messages
      render :action => 'show'
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

end
