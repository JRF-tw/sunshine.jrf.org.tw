class Admin::LawyerCreateContext < BaseContext
  PERMITS = [:name, :current, :avatar, :gender, :birth_year, :memo, :email].freeze
  
  before_perform :build_lawyer
  before_perform :skip_confirmation_mail
  attr_reader :lawyer

  def initialize(params)
    @params = permit_params(params[:admin_lawyer] || params, PERMITS)
  end

  def perform
    run_callbacks :perform do
      return add_error(:data_create_fail, @lawyer.errors.full_messages.join("\n")) unless @lawyer.save
      @lawyer
    end
  end


  private

  def build_lawyer
    @lawyer = Admin::Lawyer.new(@params)
  end

  def skip_confirmation_mail
    @lawyer.skip_confirmation_notification!
  end

end
