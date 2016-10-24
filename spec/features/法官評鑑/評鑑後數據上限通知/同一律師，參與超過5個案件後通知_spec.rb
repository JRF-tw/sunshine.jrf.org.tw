require 'rails_helper'
feature '法官評鑑', type: :request do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:schedule) { create :schedule, story: story }
  let!(:judge) { create :judge, court: court }
  let!(:schedule_score_params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type, start_on: schedule.start_on, confirmed_realdate: false, judge_name: judge.name, command_score: 1, attitude_score: 1, note: 'xxxxx', appeal_judge: false } }
  let!(:verdict_score_params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type, judge_name: judge.name, quality_score: 1, note: 'xxxxx', appeal_judge: false } }
  before { signin_lawyer(lawyer) }

  feature '評鑑後數據上限通知' do

    feature '同一律師，參與超過 5 個案件後通知' do
      Given '律師已評鑑的案件數達 5 件' do
        before { create_list :schedule_score, 5, schedule_rater: lawyer }
        When '律師新增「未評鑑案件」的「開庭評鑑」' do
          subject { post '/lawyer/score/schedules', schedule_score: schedule_score_params }
          Then '發送通知' do
            expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify)
          end
        end

        When '律師新增「未評鑑案件」的「判決評鑑」' do
          before { story.update_attributes(adjudge_date: Time.now) }
          subject { post '/lawyer/score/verdicts', verdict_score: verdict_score_params }
          Then '發送通知' do
            expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify)
          end
        end

        When '律師新增「已評鑑案件」的「開庭評鑑」' do
          before { create :schedule_score, schedule_rater: lawyer, story: story }
          subject { post '/lawyer/score/schedules', schedule_score: schedule_score_params }
          Then '不送通知' do
            expect { subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify)
          end
        end

        When '律師新增「已評鑑案件」的「判決評鑑」' do
          before { create :schedule_score, schedule_rater: lawyer, story: story }
          before { story.update_attributes(adjudge_date: Time.now) }
          subject { post '/lawyer/score/verdicts', verdict_score: verdict_score_params }
          Then '不發送通知' do
            expect { subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify)
          end
        end
      end
    end
  end
end
