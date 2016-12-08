class Admin::ProsecutorsOfficeCreateContext < BaseContext
  PERMITS = [:full_name, :name, :weight, :is_hidden, :court, :court_id].freeze

  before_perform :build_prosecutors_office
  attr_reader :prosecutors_office

  def initialize(params)
    @params = permit_params(params[:admin_prosecutors_office] || params, PERMITS)
  end

  def perform
    run_callbacks :perform do
      if @prosecutors_office.save
        @prosecutors_office
      else
        add_error(:data_create_fail, @prosecutors_office.errors.full_messages)
      end
    end
  end

  private

  def build_prosecutors_office
    @prosecutors_office = Admin::ProsecutorsOffice.new(@params)
  end

end
