class Admin::CourtDeleteContext < BaseContext

  def initialize(court)
    @court = court
  end

  def perform
    run_callbacks :perform do
      @court.destroy
    end
  end

end
