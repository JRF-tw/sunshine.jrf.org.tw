class Party::RegisterCheckContext < BaseContext
  PERMITS = [:name, :identify_number, :password, :password_confirmation].freeze

  before_perform :check_params_data
  before_perform :check_party_params_exist
  before_perform :check_password_valid
  after_perform :alert!

  def initialize(params)
    @params = permit_params(params[:party] || params, PERMITS)
    @params[:policy_agreement] = true
  end

  def perform
    run_callbacks :perform do
      true
    end
  end

  private

  def check_params_data
    context = Party::IdentifyNumberCheckContext.new(@params)
    return add_error(:data_invalid, context.error_messages.join(", ")) unless context.perform
  end

  def check_party_params_exist
    add_error(:password_blank) if @params[:password].blank?
    add_error(:password_confirmation_blank) if @params[:password_confirmation].blank?
    return false if errors.present?
  end

  def check_password_valid
    add_error(:password_less_than_minimum) if @params[:password].size < 8
    add_error(:password_not_match_confirmation) if @params[:password] != @params[:password_confirmation]
    return false if errors.present?
  end

  def alert!
    SlackService.notify_user_activity_alert("新當事人註冊 : #{ SlackService.render_link(admin_parties_url(q: { name_cont: @params[:name] }, host: Setting.host), @params[:name])}  已經申請註冊")
  end
end
