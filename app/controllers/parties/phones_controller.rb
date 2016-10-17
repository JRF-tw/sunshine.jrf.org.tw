class Parties::PhonesController < Parties::BaseController
  before_action :set_phone?, only: []
  before_action :can_verify?, only: [:verify, :verifing, :resend_verify_sms]

  def new
    # meta
    set_meta(
      title: '當事人新增手機頁',
      description: '當事人新增手機頁',
      keywords: '當事人新增手機頁'
    )
  end

  def create
    context = Party::SetPhoneContext.new(current_party)
    if context.perform(party_params)
      redirect_to verify_party_phone_path, flash: { success: '已寄出簡訊認證碼' }
    else
      flash[:error] = context.error_messages.join(", ")
      render "new"
    end
  end

  def edit
    @phone_form = Party::ChangePhoneFormObject.new(current_party)
    # meta
    set_meta(
      title: '當事人更改手機頁',
      description: '當事人更改手機頁',
      keywords: '當事人更改手機頁'
    )
  end

  def update
    context = Party::SetPhoneContext.new(current_party)
    if context.perform(party_params)
      redirect_to verify_party_phone_path, flash: { success: '已寄出簡訊認證碼' }
    else
      flash[:error] = context.error_messages.join(", ")
      render 'edit'
    end
  end

  def verify
    # meta
    set_meta(
      title: '當事人手機驗證頁',
      description: '當事人手機驗證頁',
      keywords: '當事人手機驗證頁'
    )
  end

  def verifing
    context = Party::VerifyPhoneContext.new(@verify_form)
    if context.perform
      redirect_to party_root_path, flash: { success: "已驗證成功" }
    elsif context.errors.include?(:retry_verify_count_out_range)
      redirect_to edit_party_phone_path, flash: { error: context.error_messages.join(', ').to_s }
    else
      flash[:error] = context.error_messages.join(", ")
      render "verify"
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

  def init_verify_form_object
    @verify_form = Party::VerifyPhoneFormObject.new(current_party, verify_params)
  end

  def verify_params
    params.fetch(:verify_form, {}).permit(:phone_varify_code)
  end

  def can_verify?
    redirect_to edit_party_phone_path, flash: { error: '請先設定手機號碼' } unless current_party.phone_varify_code.value
  end
end
