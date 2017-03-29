class CourtObserver::ScheduleScoreDeleteContext < BaseContext

  def initialize(schedule_score)
    @schedule_score = schedule_score
  end

  def perform
    run_callbacks :perform do
      @schedule_score.destroy
    end
  end

end
