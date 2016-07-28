require "rails_helper"
describe "案件視角的評鑑後人數通知", type: :request do
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:schedule) { create :schedule, story: story }
  let!(:judge) { create :judge, court: court }

  context "當事人" do
    let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.date, confirmed_realdate: false, judge_name: judge.name, rating_score: 1, note: "xxxxx", appeal_judge: false } }
    let!(:party) { create :party }
    before { signin_party(party) }

    context "Given 案件正進行開庭評鑑中，已評鑑的當事人人數達 3 人" do
      before { create_list :schedule_score, 3, :by_party, story: story }
      subject { post "/party/score/schedules", schedule_score: params }

      context "When 新的當事人新增開庭評鑑" do
        it "發送 Slack 通知" do
          expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end

      context "When 已評鑑過的當事人新增開庭評鑑" do
        before { create :schedule_score, schedule_rater: party, story: story }

        it "不發送 Slack 通知" do
          expect { subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end
    end

    context "Given 案件正進行判決評鑑中，已評鑑的當事人人數達 3 人" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, rating_score: 1, note: "xxxxx", appeal_judge: false } }
      before { story.update_attributes(adjudge_date: Time.zone.today) }
      before { create_list :verdict_score, 3, :by_party, story: story }

      context "When 新的當事人新增判決評鑑" do
        subject { post "/party/score/verdicts", verdict_score: params }

        it "發送 Slack 通知" do
          expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end

      context "When 已評鑑過的當事人新增判決評鑑" do
        before { create :verdict_score, verdict_rater: party, story: story }
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

    context "Given 案件正進行開庭評鑑中，已評鑑的律師人數達 5 人" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.date, confirmed_realdate: false, judge_name: judge.name, command_score: 1, attitude_score: 1, note: "xxxxx", appeal_judge: false } }
      before { create_list :schedule_score, 5, story: story }

      context "When 新的律師新增開庭評鑑" do
        subject { post "/lawyer/score/schedules", schedule_score: params }

        it "發送 Slack 通知" do
          expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end

      context "When 已評鑑過的律師新增開庭評鑑" do
        before { create :schedule_score, schedule_rater: lawyer, story: story }

        it "不發送 Slack 通知" do
          expect { subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end
    end

    context "Given 案件正進行判決評鑑中，已評鑑的律師人數達 5 人" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, quality_score: 1, note: "xxxxx", appeal_judge: false } }
      before { story.update_attributes(adjudge_date: Time.zone.today) }
      before { create_list :verdict_score, 5, story: story }

      context "When 新的律師新增判決評鑑" do
        before { create_list :verdict_score, 5, story: story }
        subject { post "/lawyer/score/verdicts", verdict_score: params }

        it "發送 Slack 通知" do
          expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end

      context "When 已評鑑過的律師新增判決評鑑" do
        before { create :verdict_score, verdict_rater: lawyer, story: story }
        subject { post "/lawyer/score/verdicts", verdict_score: params }

        it "不發送 Slack 通知" do
          expect { subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify)
        end
      end
    end
  end
end
