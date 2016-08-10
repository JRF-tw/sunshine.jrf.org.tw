class Party::RegisterCheckContext < BaseContext
  PERMITS = [:name, :identify_number, :password, :password_confirmation].freeze

  before_perform :check_params_data
  before_perform :check_party_params_exist
  before_perform :check_password_valid

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
    add_error(:data_blank, "密碼 不可為空白字元") if @params[:password].blank?
    add_error(:data_blank, "密碼確認 不可為空白字元") if @params[:password_confirmation].blank?
    return false if errors.present?
  end

  def check_password_valid
    add_error(:data_invalid, "密碼 不得小於八個字元") if @params[:password].size < 8
    add_error(:data_invalid, "密碼 需與密碼確認相同") if @params[:password] != @params[:password_confirmation]
    return false if errors.present?
  end

end
