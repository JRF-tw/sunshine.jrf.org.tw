class Party::RegisterCheckContext < BaseContext
  PERMITS = [:name, :identify_number, :password, :password_confirmation].freeze

  before_perform :check_party_params_exist
  before_perform :check_party_not_used
  before_perform :check_agree_policy

  def initialize(params)
    @params = permit_params(params[:party] || params, PERMITS)
    @params[:policy_agreement] = true if params[:policy_agreement] == "1"
  end

  def perform
    run_callbacks :perform do
      true
    end
  end

  private

  def check_agree_policy
    return add_error(:without_policy_agreement, "您尚未勾選同意條款") unless @params[:policy_agreement]
  end

  def check_party_params_exist
    add_error(:date_blank, "姓名 不可為空白字元") if @params[:name].blank?
    add_error(:date_blank, "身分證字號 不可為空白字元") if @params[:identify_number].blank?
    add_error(:date_blank, "密碼 不可為空白字元") if @params[:password].blank?
    add_error(:date_blank, "密碼確認 不可為空白字元") if @params[:password_confirmation].blank?

    return false if errors.present?
  end

  def check_party_not_used
    if Party.pluck(:identify_number).include?(@params[:identify_number])
      add_error(:party_exist, "此身分證字號已經被使用 <a href='/party/appeal/new'>人工申訴連結</a>")
    end
  end

end
