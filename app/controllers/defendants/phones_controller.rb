class Defendants::PhonesController < Defendants::BaseController
  before_action :set_phone?, only: []
  before_action :can_verify?, only: [:verify, :verifing, :resend_verify_sms]

  def new

  end

  def create
    context = Defendant::SetPhoneContext.new(current_defendant)
    if context.perform(defendant_params)
      redirect_to verify_defendants_phone_path, flash: { success: "已寄出簡訊認證碼" }
    else
      flash[:error] = context.error_messages.join(", ")
      render "new"
    end
  end

  def edit
  end

  def update
    context = Defendant::SetPhoneContext.new(current_defendant)
    if context.perform(defendant_params)
      redirect_to verify_defendants_phone_path, flash: { success: "已寄出簡訊認證碼" }
    else
      flash[:error] = context.error_messages.join(", ")
      render "edit"
    end
  end

  def verify

  end

  def verifing
    context = Defendant::VerifyPhoneContext.new(current_defendant)
    if context.perform(defendant_params)
      redirect_to defendants_profile_path, flash: { success: "已驗證成功" }
    elsif context.errors.include?(:retry_verify_count_out_range)
      redirect_to edit_defendants_phone_path, flash: { error: "#{context.error_messages.join(", ")}" }
    else
      flash[:error] = context.error_messages.join(", ")
      render "verify"
    end
  end

  def resend
    context = Defendant::ResendPhoneVerifySmsContext.new(current_defendant)
    if context.perform
      redirect_to verify_defendants_phone_path, flash: { success: "已重新寄送簡訊" }
    else
      redirect_to verify_defendants_phone_path, flash: { error: "#{context.error_messages.join(", ")}" }
    end
  end

  private

  def defendant_params
    params.fetch(:defendant, {}).permit(:phone_number, :phone_varify_code)
  end

  def can_verify?
    redirect_to edit_defendants_phone_path, flash: { error: "請先設定手機號碼" } unless current_defendant.phone_varify_code.value
  end
end
