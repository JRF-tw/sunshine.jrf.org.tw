class SiteMapGeneratorWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options retry: 3

  recurrence backfill: true do
    daily.hour_of_day(5)
  end

  def perform
    `rake "-s sitemap:refresh"` if Rails.env == 'production'
  end
end
