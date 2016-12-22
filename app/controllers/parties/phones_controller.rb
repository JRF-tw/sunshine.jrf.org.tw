class Parties::PhonesController < Parties::BaseController
  before_action :set_phone?, only: []
  before_action :can_verify?, only: [:verify, :verifing, :resend]
  before_action :init_meta, only: [:new, :edit, :verify]

  def new
    @phone_form = Party::ChangePhoneFormObject.new(current_party)
  end

  def create
    context = Party::SetPhoneContext.new(current_party, params)
    @phone_form = context.perform
    if context.has_error?
      flash[:error] = context.error_messages.join(', ')
      render 'new'
    else
      redirect_to verify_party_phone_path, flash: { success: '已寄出簡訊認證碼' }
    end
  end

  def edit
    @phone_form = Party::ChangePhoneFormObject.new(current_party)
  end

  def update
    context = Party::SetPhoneContext.new(current_party, params)
    @phone_form = context.perform
    if context.has_error?
      flash[:error] = context.error_messages.join(', ')
      render 'edit'
    else
      redirect_to verify_party_phone_path, flash: { success: '已寄出簡訊認證碼' }
    end
  end

  def verify
    @verify_form = Party::VerifyPhoneFormObject.new(current_party)
  end

  def verifing
    context = Party::VerifyPhoneContext.new(current_party, params)
    @verify_form = context.perform
    if !context.has_error?
      redirect_to party_root_path, flash: { success: '已驗證成功' }
    elsif context.errors.include?(:retry_verify_count_out_range)
      redirect_to edit_party_phone_path, flash: { error: context.error_messages.join(', ').to_s }
    else
      flash[:error] = context.error_messages.join(', ')
      render 'verify'
    end
  end

  def resend
    context = Party::ResendPhoneVerifySmsContext.new(current_party)
    if context.perform
      redirect_to verify_party_phone_path, flash: { success: '已重新寄送簡訊' }
    else
      redirect_to verify_party_phone_path, flash: { error: context.error_messages.join(', ').to_s }
    end
  end

  private

  def can_verify?
    redirect_to edit_party_phone_path, flash: { error: '請先設定手機號碼' } unless current_party.phone_varify_code.value
  end
end
