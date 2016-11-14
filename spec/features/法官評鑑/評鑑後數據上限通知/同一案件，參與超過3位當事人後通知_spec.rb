require 'rails_helper'
feature '法官評鑑', type: :request do
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:schedule) { create :schedule, story: story }
  let!(:judge) { create :judge, court: court }
  let!(:party) { create :party }
  let!(:schedule_score_params) { attributes_for(:schedule_score_for_params, court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type, judge_name: judge.name) }
  let!(:verdict_score_params) { attributes_for(:verdict_score_for_params, court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type) }
  before { signin_party(party) }

  feature '評鑑後數據上限通知' do
    feature '同一案件，參與超過 3 位當事人後通知' do
      Given '案件的參與當事人數已達 3 人' do
        before { create_list :schedule_score, 3, :by_party, story: story }
        When '「未評鑑此案件當事人」新增案件的「開庭評鑑」' do
          subject { post '/party/score/schedules', schedule_score: schedule_score_params }
          Then '發送通知' do
            expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify)
          end
        end

        When '「未評鑑此案件當事人」新增案件的「判決評鑑」' do
          before { story.update_attributes(adjudge_date: Time.zone.today) }
          subject { post '/party/score/verdicts', verdict_score: verdict_score_params }
          Then '發送通知' do
            expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify)
          end
        end

        When '「已評鑑此案件當事人」新增案件的「開庭評鑑」' do
          before { create :schedule_score, schedule_rater: party, story: story }
          subject { post '/party/score/schedules', schedule_score: schedule_score_params }
          Then '不發送通知' do
            expect { subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify)
          end
        end

        When '「已評鑑此案件當事人」新增案件的「判決評鑑」' do
          before { create :schedule_score, schedule_rater: party, story: story }
          before { story.update_attributes(adjudge_date: Time.zone.today) }
          subject { post '/party/score/verdicts', verdict_score: verdict_score_params }
          Then '不發送通知' do
            expect { subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify)
          end
        end
      end
    end
  end
end
