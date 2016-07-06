class Admin::CourtCreateContext < BaseContext
  PERMITS = [:court_type, :full_name, :name, :weight, :is_hidden].freeze

  before_perform :build_court
  attr_reader :court

  def initialize(params)
    @params = permit_params(params[:admin_court] || params, PERMITS)
  end

  def perform
    run_callbacks :perform do
      if @court.save
        @court
      else
        add_error(:data_create_fail, @court.errors.full_messages)
      end
    end
  end

  private

  def build_court
    @court = Admin::Court.new(@params)
  end

end
