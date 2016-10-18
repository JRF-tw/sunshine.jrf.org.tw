class Party::VerifyPhoneContext < BaseContext
  PERMITS = [:phone_varify_code].freeze

  before_perform  :init_verify_form_object
  after_perform   :build_message
  after_perform   :confirmed
  after_perform   :reset_data

  def initialize(party)
    @party = party
  end

  def perform(params)
    @params = permit_params(params[:verify_form] || params, PERMITS)
    run_callbacks :perform do
      unless @form_object.save
        record_retry_count
        reset_data_out_retry_range
      end
    end
    @form_object
  end

  private

  def init_verify_form_object
    @form_object = Party::VerifyPhoneFormObject.new(@party, @params)
  end

  def record_retry_count
    @party.retry_verify_count.increment
  end

  def reset_data_out_retry_range
    if @party.retry_verify_count.value >= 3
      reset_data
      return add_error(:retry_verify_count_out_range)
    else
      return add_error(:data_update_fail, @form_object.full_error_messages)
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
