class Party::IdentifyNumberCheckContext < BaseContext
  PERMITS = [:name, :identify_number, :policy_agreement].freeze

  before_perform :check_params_valid
  before_perform :check_identify_number_pattern
  before_perform :check_identify_number_not_used
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

  def check_params_valid
    add_error(:name_blank) if @params[:name].blank?
    add_error(:identify_number_blank) if @params[:identify_number].blank?
    return false if errors.present?
  end

  def check_identify_number_pattern
    return add_error(:identify_number_invalid) unless @params[:identify_number][/\A[A-Z]{1}[1-2]{1}[0-9]{8}\z/]
  end

  def check_identify_number_not_used
    if Party.pluck(:identify_number).include?(@params[:identify_number])
      return add_error(:party_exist_manual_check)
    end
  end

  def check_agree_policy
    return add_error(:without_policy_agreement) unless @params[:policy_agreement]
  end
end
