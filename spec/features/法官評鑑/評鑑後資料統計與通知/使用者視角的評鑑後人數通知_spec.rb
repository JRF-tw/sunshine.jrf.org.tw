require "rails_helper"
describe "法官評鑑 - 評鑑後資料統計與通知 - 使用者視角的評鑑後人數通知", type: :request do
  let!(:story) { create(:story) }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:schedule) { create :schedule, story: story }
  let!(:judge) { create :judge, court: court }

  context "當事人" do
    let!(:party) { create :party }
    before { signin_party(party) }

    context "Given 當事人已評鑑的案件數達 2 件" do
      before { create_list :schedule_score, 2, schedule_rater: party }

      context "When 當事人新增新案件的開庭評鑑" do
        let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, start_on: schedule.start_on, confirmed_realdate: false, judge_name: judge.name, rating_score: 1, note: "xxxxx", appeal_judge: false } }
        subject { post "/party/score/schedules", schedule_score: params }

        it "Then 發送 Slack 通知" do
          expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end

      context "When 當事人新增新案件的判決評鑑" do
        let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, rating_score: 1, note: "xxxxx", appeal_judge: false } }
        before { story.update_attributes(adjudge_date: Time.now) }
        subject { post "/party/score/verdicts", verdict_score: params }

        it "Then 發送 Slack 通知" do
          expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end

      context "When 當事人新增舊案件的開庭評鑑" do
        let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, start_on: schedule.start_on, confirmed_realdate: false, judge_name: judge.name, rating_score: 1, note: "xxxxx", appeal_judge: false } }
        before { create :schedule_score, schedule_rater: party, story: story }
        subject { post "/party/score/schedules", schedule_score: params }

        it "Then 不發送 Slack 通知" do
          expect { subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end

      context "Then When 當事人新增舊案件的判決評鑑" do
        let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, rating_score: 1, note: "xxxxx", appeal_judge: false } }
        subject { post "/party/score/verdicts", verdict_score: params }

        it "不發送 Slack 通知" do
          expect { subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end
    end
  end

  context "律師" do
    let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
    before { signin_lawyer(lawyer) }

    context "Given 律師已評鑑的案件數達 5 件" do
      before { create_list :schedule_score, 5, schedule_rater: lawyer }

      context "When 律師新增新案件的開庭評鑑" do
        let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, start_on: schedule.start_on, confirmed_realdate: false, judge_name: judge.name, command_score: 1, attitude_score: 1, note: "xxxxx", appeal_judge: false } }
        subject { post "/lawyer/score/schedules", schedule_score: params }

        it "Then 發送 Slack 通知" do
          expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end

      context "When 律師新增新案件的判決評鑑" do
        let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, quality_score: 1, note: "xxxxx", appeal_judge: false } }
        before { story.update_attributes(adjudge_date: Time.now) }
        subject { post "/lawyer/score/verdicts", verdict_score: params }

        it "Then 發送 Slack 通知" do
          expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end

      context "When 律師新增舊案件的開庭評鑑" do
        let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, start_on: schedule.start_on, confirmed_realdate: false, judge_name: judge.name, command_score: 1, attitude_score: 1, note: "xxxxx", appeal_judge: false } }
        before { create :schedule_score, schedule_rater: lawyer, story: story }
        subject { post "/lawyer/score/schedules", schedule_score: params }

        it "Then 不發送 Slack 通知" do
          expect { subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end

      context "When 律師新增舊案件的判決評鑑" do
        let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, quality_score: 1, note: "xxxxx", appeal_judge: false } }
        subject { post "/lawyer/score/verdicts", verdict_score: params }

        it "Then 不發送 Slack 通知" do
          expect { subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end
    end
  end
end
