require 'rails_helper'
feature '法官評鑑', type: :request do
  let!(:party) { create :party }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:schedule) { create :schedule, story: story }
  let!(:judge) { create :judge, court: court }
  let!(:schedule_score_params) { attributes_for(:schedule_score_for_params, court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type, judge_name: judge.name) }
  let!(:verdict_score_params) { attributes_for(:verdict_score_for_params, court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type) }
  before { signin_party(party) }

  feature '評鑑後數據上限通知' do
    feature '同一當事人，參與超過 2 個案件後通知' do
      Given '當事人已評鑑的案件數達 2 件' do
        before { create_list :schedule_score, 2, schedule_rater: party }
        When '當事人新增「未評鑑案件」的「開庭評鑑」' do
          subject { post '/party/score/schedules', schedule_score: schedule_score_params }
          Then '發送通知' do
            expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify)
          end
        end

        When '當事人新增「未評鑑案件」的「判決評鑑」' do
          let!(:verdict) { create :verdict, story: story }
          before { story.update_attributes(adjudged_on: Time.now, is_adjudge: true) }
          subject { post '/party/score/verdicts', verdict_score: verdict_score_params }
          Then '發送通知' do
            expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify)
          end
        end

        When '當事人新增「已評鑑案件」的「開庭評鑑」' do
          before { create :schedule_score, schedule_rater: party, story: story }
          subject { post '/party/score/schedules', schedule_score: schedule_score_params }
          Then '不送通知' do
            expect { subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify)
          end
        end

        When '當事人新增「已評鑑案件」的「判決評鑑」' do
          let!(:verdict) { create :verdict, story: story }
          before { create :schedule_score, schedule_rater: party, story: story }
          before { story.update_attributes(adjudged_on: Time.now) }
          subject { post '/party/score/verdicts', verdict_score: verdict_score_params }
          Then '不發送通知' do
            expect { subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify)
          end
        end
      end
    end
  end
end
