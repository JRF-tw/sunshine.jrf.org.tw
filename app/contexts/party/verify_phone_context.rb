class Party::VerifyPhoneContext < BaseContext
  PERMITS = [:phone_varify_code].freeze

  before_perform  :record_retry_count, unless: :valid?
  before_perform  :reset_data_out_retry_range, unless: :valid?
  before_perform  :assign_value
  after_perform   :build_message
  after_perform   :confirmed
  after_perform   :reset_data

  def initialize(party)
    @party = party
  end

  def perform(params)
    @params = permit_params(params[:party] || params, PERMITS)

    run_callbacks :perform do
      return add_error(:data_update_fail, @party.errors.full_messages.join(',').to_s) unless @party.save
      true
    end
  end

  private

  def valid?
    @params[:phone_varify_code] == @party.phone_varify_code.value
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

  def assign_value
    @party.assign_attributes(phone_number: @party.unconfirmed_phone.value)
    @party.unconfirmed_phone = nil
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
