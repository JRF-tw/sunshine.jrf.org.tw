class Defendants::BaseController < ApplicationController
  layout 'defendant'
  before_action :authenticate_defendant!
  before_action :set_phone?

  def index
  end

  def profile
  end

  def edit_email
    prev_unconfirmed_email = current_bystander.unconfirmed_email if current_bystander.respond_to?(:unconfirmed_email)
  end

  def update_email
    context = Defendant::ChangeEmailContext.new(current_defendant)
    if context.perform(params[:defendant])
      redirect_to defendants_profile_path, flash: { success: "email已修改" }
    else
      redirect_to defendants_edit_email_path, flash: { error: "#{context.error_messages.join(", ")}" }
    end
  end

  private

  def set_phone?
    redirect_to new_defendants_phone_path unless current_defendant.phone_number.present?
  end

  def send_reset_password_sms
    defendant_params = { identify_number: current_defendant.identify_number, phone_number: current_defendant.phone_number }
    context = Defendant::SendResetPasswordSmsContext.new(defendant_params)
    if context.perform
      redirect_to defendants_profile_path, flash: { success: "已寄送重設密碼簡訊" }
    else
      redirect_to defendants_profile_path, flash: { error: "#{context.error_messages.join(", ")}" }
    end
  end

end
