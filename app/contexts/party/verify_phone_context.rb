class Party::VerifyPhoneContext < BaseContext

  before_perform  :record_retry_count, unless: :valid?
  before_perform  :reset_data_out_retry_range, unless: :valid?
  after_perform   :build_message
  after_perform   :confirmed
  after_perform   :reset_data

  def initialize(verify_form)
    @verify_form = verify_form
    @party = @verify_form.party
  end

  def perform
    run_callbacks :perform do
      return add_error(:data_update_fail, @verify_form.errors.full_messages.join(',').to_s) unless @verify_form.save
      true
    end
  end

  private

  def valid?
    @verify_form.phone_varify_code == @party.phone_varify_code.value
  end

  def record_retry_count
    @party.retry_verify_count.increment
  end

  def reset_data_out_retry_range
    if @party.retry_verify_count.value >= 3
      reset_data
      return add_error(:retry_verify_count_out_range)
    else
      return add_error(:wrong_verify_code)
    end
  end

  def build_message
    @message = '當事人手機驗證成功'
  end

  def confirmed
    @party.phone_confirm!
  end

  def reset_data
    @party.unconfirmed_phone = nil
    @party.phone_varify_code = nil
    @party.retry_verify_count.reset
  end
end
