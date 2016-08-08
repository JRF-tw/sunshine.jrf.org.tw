class Party::IdentifyNumberCheckContext < BaseContext
  PERMITS = [:name, :identify_number, :policy_agreement].freeze

  before_perform :check_party_params_exist
  before_perform :check_identify_number_valid
  before_perform :check_party_not_used
  before_perform :check_agree_policy

  def initialize(params)
    @params = permit_params(params[:party] || params, PERMITS)
    @params[:policy_agreement] = true if params[:policy_agreement] == "1"
  end

  def perform
    run_callbacks :perform do
      @params.delete("policy_agreement")
      @party = Party.new(@params)
    end
  end

  private

  def check_party_params_exist
    add_error(:data_blank, "姓名 不可為空白字元") if @params[:name].blank?
    add_error(:data_blank, "身分證字號 不可為空白字元") if @params[:identify_number].blank?
    return false if errors.present?
  end

  def check_identify_number_valid
    return add_error(:data_invalid, "身分證字號格式不符(英文字母請大寫)") unless @params[:identify_number][/\A[A-Z]{1}[1-2]{1}[0-9]{8}\z/]
  end

  def check_agree_policy
    return add_error(:without_policy_agreement, "您尚未勾選同意條款") unless @params[:policy_agreement]
  end

  def check_party_not_used
    if Party.pluck(:identify_number).include?(@params[:identify_number])
      return add_error(:party_exist, "此身分證字號已經被使用 <a href='#{new_party_appeal_path}'>人工申訴連結</a>")
    end
  end

end
