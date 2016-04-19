class LawyerCreateContext < BaseContext
  PERMITS = [:name, :current, :avatar, :gender, :birth_year, :memo].freeze
  
  before_perform :build_lawyer

  def initialize(params)
    @params = permit_params(params[:admin_lawyer] || params, PERMITS)
  end

  def perform
    run_callbacks :perform do
      if @lawyer.save
        @lawyer
      else
        add_error(:data_create_fail, @lawyer.errors.full_messages.join("\n"))
      end
    end
  end

  private

  def build_lawyer
    @lawyer = Admin::Lawyer.new(@params)
  end

end