class Party::PhonesController < Party::BaseController
  before_action :set_phone?, only: []
  before_action :can_verify?, only: [:verify, :verifing, :resend_verify_sms]

  def new
  end

  def create
    context = Party::SetPhoneContext.new(current_party)
    if context.perform(party_params)
      redirect_to verify_party_phone_path, flash: { success: "已寄出簡訊認證碼" }
    else
      flash[:error] = context.error_messages.join(", ")
      render "new"
    end
  end

  def edit
  end

  def update
    context = Party::SetPhoneContext.new(current_party)
    if context.perform(party_params)
      redirect_to verify_party_phone_path, flash: { success: "已寄出簡訊認證碼" }
    else
      flash[:error] = context.error_messages.join(", ")
      render "edit"
    end
  end

  def verify
  end

  def verifing
    context = Party::VerifyPhoneContext.new(current_party)
    if context.perform(party_params)
      redirect_to party_profile_path, flash: { success: "已驗證成功" }
    elsif context.errors.include?(:retry_verify_count_out_range)
      redirect_to edit_party_phone_path, flash: { error: context.error_messages.join(", ").to_s }
    else
      flash[:error] = context.error_messages.join(", ")
      render "verify"
    end
  end

  def resend
    context = Party::ResendPhoneVerifySmsContext.new(current_party)
    if context.perform
      redirect_to verify_party_phone_path, flash: { success: "已重新寄送簡訊" }
    else
      redirect_to verify_party_phone_path, flash: { error: context.error_messages.join(", ").to_s }
    end
  end

  private

  def party_params
    params.fetch(:party, {}).permit(:phone_number, :phone_varify_code)
  end

  def can_verify?
    redirect_to edit_party_phone_path, flash: { error: "請先設定手機號碼" } unless current_party.phone_varify_code.value
  end
end
