class Admin::LawyerCreateContext < BaseContext
  PERMITS = [:name, :current, :avatar, :gender, :birth_year, :memo, :email].freeze
  
  before_perform :build_lawyer
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

end
