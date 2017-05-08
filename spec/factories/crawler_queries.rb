FactoryGirl.define do
  factory :crawler_queries_for_params, class: CrawlerQueries do
    scrap_id { rand(1..10) }
    court { create :court }
    type 'V'
    year { rand(70..105) }
    word '火'
    number { rand(100..999) }
    start_date { Time.zone.today.strftime('%Y%m%d') }
    end_date { Time.zone.today.strftime('%Y%m%d') }
  end
end
