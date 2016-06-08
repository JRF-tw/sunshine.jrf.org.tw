class Admin::LawyerUpdateContext < BaseContext
  PERMITS = [:name, :current, :avatar, :gender, :birth_year, :memo, :email, :password].freeze

  before_perform :assign_value
  after_perform :confirm_email

  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform(params)
    @params = permit_params(params[:admin_lawyer] || params[:lawyer] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, @lawyer.errors.full_messages.join("\n")) unless @lawyer.save
      true
    end 
  end

  private

  def assign_value
    @lawyer.assign_attributes @params
  end

  def confirm_email
    @lawyer.confirm! if @lawyer.unconfirmed_email.present?
  end
end 
