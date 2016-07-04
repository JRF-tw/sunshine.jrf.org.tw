class Lawyer::FindByConfirmationTokenContext < BaseContext
  PERMITS = [:confirmation_token].freeze

  before_perform :find_lawyer

  def initialize(params)
    @params = permit_params(params[:lawyer] || params, PERMITS)
  end

  def perform
    run_callbacks :perform do
      return add_error(:lawyer_not_found, "無此律師資料") unless @lawyer
      @lawyer
    end
  end

  def find_lawyer
    @lawyer = Lawyer.find_by_confirmation_token(@params[:confirmation_token])
  end

end
