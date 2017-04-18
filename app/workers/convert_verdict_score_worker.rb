class ConvertVerdictScoreWorker
  include ScoreIntervalConcern
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options retry: 3

  recurrence backfill: true do
    daily.hour_of_day(3)
  end

  def perform
    find_stories.each do |story|
      Story::CalculateVerdictScoresContext.delay.perform(story)
    end
  end

  private

  def find_stories
    Story.not_caculate.where('pronounced_on < ?', Time.zone.today - VERDICT_INTERVAL)
  end
end
