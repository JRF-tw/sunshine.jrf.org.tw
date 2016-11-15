class Party::SetPhoneContext < BaseContext
  PERMITS = [:unconfirmed_phone].freeze
  SENDINGLIMIT = 2

  before_perform :init_form_object
  before_perform :check_sms_send_count
  after_perform  :assign_verify_code
  after_perform  :set_unconfirm
  after_perform  :send_sms
  after_perform  :reset_expire_job

  def initialize(party, params)
    @party = party
    @params = permit_params(params[:phone_form] || params, PERMITS)
  end

  def perform
    run_callbacks :perform do
      add_error(:data_update_fail, @form_object.full_error_messages) unless @form_object.save
    end
    @form_object
  end

  def self.clean_expire_job_data(party)
    party.update_columns(unconfirmed_phone: nil)
    party.delete_phone_job_id = nil
  end

  private

  def init_form_object
    @form_object = Party::ChangePhoneFormObject.new(@party, @params)
  end

  def check_sms_send_count
    add_error(:send_sms_too_frequent) if @party.sms_sent_count.value >= SENDINGLIMIT
  end

  def generate_verify_code
    rand(1..9999).to_s.rjust(4, '0')
  end

  def assign_verify_code
    @party.phone_varify_code = generate_verify_code
  end

  def set_unconfirm
    @party.phone_unconfirm!
  end

  def send_sms
    SmsService.send_async(@params[:unconfirmed_phone], build_message)
    increment_sms_count
  end

  def build_message
    link = verify_party_phone_url(host: Setting.host)
    "當事人手機驗證簡訊 發送至 #{@params[:unconfirmed_phone]}: 認證碼 : #{@verify_code}, #{link}"
  end

  def increment_sms_count
    @party.sms_sent_count.increment
  end

  def reset_expire_job
    Sidekiq::ScheduledSet.new.find_job(@party.delete_phone_job_id.value).try(:delete)
    @party.delete_phone_job_id = self.class.delay_until(1.hour.from_now).clean_expire_job_data(@party)
  end

end
