class Defendant::VerifyPhoneContext < BaseContext
  PERMITS = [:phone_varify_code].freeze

  before_perform  :record_retry_count, unless: :valid?
  before_perform  :reset_data_out_retry_range, unless: :valid?
  before_perform  :assign_value
  after_perform   :build_message
  after_perform   :confirmed
  after_perform   :send_sms
  after_perform   :reset_data

  def initialize(defendant)
    @defendant = defendant
  end

  def perform(params)
    @params = permit_params(params[:defendant] || params, PERMITS)

    run_callbacks :perform do
      return add_error(:data_update_fail, "#{@defendant.errors.full_messages.join(",")}") unless @defendant.save
      true
    end
  end

  private

  def valid?
    @params[:phone_varify_code] == @defendant.phone_varify_code.value
  end

  def record_retry_count
    @defendant.retry_verify_count.increment
  end

  def reset_data_out_retry_range
    if @defendant.retry_verify_count.value >= 3
      reset_data
      return add_error(:retry_verify_count_out_range, "驗證碼輸入錯誤超過三次, 請重新設定手機號碼")
    else
      return add_error(:data_update_fail, "驗證碼輸入錯誤")
    end
  end

  def assign_value
    @defendant.assign_attributes(phone_number: @defendant.unconfirmed_phone, unconfirmed_phone: nil)
  end

  def build_message
    @message = "當事人手機驗證成功"
  end

  def confirmed
    @defendant.confirm!
  end

  def send_sms
    SmsService.send_async(@defendant.phone_number, @message)
  end

  def reset_data
    @defendant.phone_varify_code = nil
    @defendant.retry_verify_count.reset
    @defendant.update_attributes(unconfirmed_phone: nil)
  end
end

