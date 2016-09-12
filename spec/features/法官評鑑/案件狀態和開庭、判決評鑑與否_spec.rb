require "rails_helper"

describe "法官評鑑 - 案件狀態和開庭、判決評鑑與否", type: :request do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:judge) { create :judge, court: court }
  let!(:schedule) { create :schedule, court: court, story: story }
  before { signin_lawyer(lawyer) }

  context "Given 案件無宣判日，也沒有判決日" do
    before { story.update_attributes(adjudge_date: nil, pronounce_date: nil) }

    context "When 到新增開庭評鑑頁面時" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
      subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

      it "Then 頁面成功讀取" do
        expect(response).to be_success
      end
    end

    context "When 在新增判決時，輸入完案件資訊後" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
      subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

      it "Then 新增失敗，顯示錯誤訊息" do
        expect(response.body).to match("尚未抓到判決書")
        expect(lawyer.verdict_scores.count).to eq(0)
      end
    end
  end

  context "Given 案件有宣判日，且宣判日在未來" do
    before { story.update_attributes(pronounce_date: Time.zone.today + 3.days) }

    context "When 到新增開庭評鑑頁面時" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
      subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

      it "Then 頁面成功讀取" do
        expect(response).to be_success
      end
    end

    context "When 在新增判決時，輸入完案件資訊後" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
      subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

      it "Then 新增失敗，顯示錯誤訊息" do
        expect(response.body).to match("尚未抓到判決書")
        expect(lawyer.verdict_scores.count).to eq(0)
      end
    end
  end

  context "Given 案件有宣判日，且宣判日在過去，但尚無判決日（尚未抓到判決書）" do
    before { story.update_attributes(pronounce_date: Time.zone.today - 1.day) }

    context "When 在新增開庭評鑑時，輸入完案件資訊後" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
      subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

      it "Then 新增失敗，顯示錯誤訊息" do
        expect(response.body).to match("案件已宣判, 無法評鑑")
        expect(lawyer.verdict_scores.count).to eq(0)
      end
    end

    context "When 在新增判決評鑑時，輸入完案件資訊後" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
      subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

      it "Then 新增失敗，顯示錯誤訊息" do
        expect(response.body).to match("尚未抓到判決書")
        expect(lawyer.verdict_scores.count).to eq(0)
      end
    end
  end

  context "Given 案件抓到判決書，有更新判決日，且在可評鑑判決的期限內，尚未有判決評鑑記錄" do
    before { story.update_attributes(adjudge_date: Time.zone.today - 89.days) }

    context "When 在新增判決時，輸入完案件資訊後" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, quality_score: 1, note: "xxxxx", appeal_judge: false } }
      subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

      it "Then 頁面成功讀取" do
        expect(response).to be_success
      end
    end

    context "When 到編輯開庭評鑑頁面時" do
      let!(:schedule_score) { create :schedule_score, story: story, judge: judge, schedule_rater: lawyer }
      subject! { get "/lawyer/score/schedules/#{schedule_score.id}/edit" }

      it "Then 頁面會被 redirect" do
        expect(response).to be_redirect
      end
    end

    context "When  送出新增開庭評鑑資料時" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, start_on: schedule.start_on, confirmed_realdate: false, judge_name: judge.name, command_score: 1, attitude_score: 1, note: "xxxxx", appeal_judge: false } }
      subject { post "/lawyer/score/schedules", schedule_score: params }

      it "Then 結果會失敗" do
        expect { subject }.not_to change { lawyer.schedule_scores.count }
      end
    end

    context "When  送出編輯開庭評鑑資料時" do
      let!(:schedule_score) { create :schedule_score, story: story, judge: judge, schedule_rater: lawyer }
      let!(:params) { { command_score: 2 } }
      subject { put "/lawyer/score/schedules/#{schedule_score.id}", schedule_score: params }

      it "Then 結果會失敗" do
        expect { subject }.not_to change { schedule_score.command_score }
      end
    end

    context "When 到新增判決評鑑頁面時" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, quality_score: 1, note: "xxxxx", appeal_judge: false } }
      subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

      it "Then 頁面成功讀取" do
        expect(response).to be_success
      end
    end

    context "When 送出新增評鑑判決資料時" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, quality_score: 1, note: "xxxxx", appeal_judge: false } }
      subject! { post "/lawyer/score/verdicts", verdict_score: params }

      it "Then 成功新增判決評鑑" do
        expect(lawyer.verdict_scores.count).to eq(1)
      end

      it "Then 轉跳至感謝頁面" do
        expect(response).to be_redirect
        follow_redirect!
        expect(response.body).to match("感謝您的評鑑")
      end
    end
  end

  context "Given 案件抓到判決書，已有判決日，且在可評鑑判決的期限內，已有判決評鑑記錄" do
    before { story.update_attributes(adjudge_date: Time.zone.today - 89.days) }
    let!(:schedule_score) { create :schedule_score, story: story, judge: judge, schedule_rater: lawyer, court_id: court.id }
    let!(:verdict_score) { create :verdict_score, story: story, judge: judge, verdict_rater: lawyer, court_id: court.id }

    context "When 在新增判決時，輸入完案件資訊後" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, quality_score: 1, note: "xxxxx", appeal_judge: false } }
      subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

      it "Then 新增失敗，顯示錯誤訊息" do
        expect(response.body).to match("判決已評鑑")
      end
    end

    context "When 送出新增評鑑判決資料時" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, quality_score: 1, note: "xxxxx", appeal_judge: false } }
      subject { post "/lawyer/score/verdicts", verdict_score: params }

      it "Then 結果失敗" do
        expect { subject }.not_to change { lawyer.verdict_scores.count }
      end
    end

    context "When 到編輯判決評鑑頁面時" do
      subject! { get "/lawyer/score/verdicts/#{verdict_score.id}/edit" }

      it "Then 頁面成功讀取" do
        expect(response).to be_success
      end
    end

    context "When 送出編輯評鑑判決資料時" do
      let!(:params) { { quality_score: 2 } }
      subject! { put "/lawyer/score/verdicts/#{verdict_score.id}", verdict_score: params }

      it "Then 轉跳至感謝頁面" do
        expect(response).to be_redirect
        follow_redirect!
        expect(response.body).to match("感謝您的評鑑")
      end

      it "Then 資料成功更新" do
        expect(verdict_score.reload.quality_score).to eq(2)
      end
    end
  end

  context "Given 案件抓到判決書，已有判決日，已超過可評鑑判決的期限，無判決評鑑記錄" do
    before { story.update_attributes(adjudge_date: Time.zone.today - 91.days) }

    context "When 在新增判決時，輸入完案件資訊後" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
      subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

      it "Then 新增失敗，顯示錯誤訊息" do
        expect(response.body).to match("已超過可評鑑時間")
      end
    end

    context "When 送出新增評鑑判決資料時" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, quality_score: 1, note: "xxxxx", appeal_judge: false } }
      subject { post "/lawyer/score/verdicts", verdict_score: params }

      it "Then 結果失敗" do
        expect { subject }.not_to change { lawyer.verdict_scores.count }
      end
    end
  end

  context "Given 案件抓到判決書，已有判決日，已超過可評鑑判決的期限，有判決評鑑記錄" do
    before { story.update_attributes(adjudge_date: Time.zone.today - 91.days) }
    let!(:schedule_score) { create :schedule_score, story: story, judge: judge, schedule_rater: lawyer, court_id: court.id }
    let!(:verdict_score) { create :verdict_score, story: story, judge: judge, verdict_rater: lawyer, court_id: court.id }

    context "When 在新增判決時，輸入完案件資訊後" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
      subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

      it "Then 新增失敗，顯示錯誤訊息" do
        expect(response.body).to match("已超過可評鑑時間")
      end
    end

    context "When 送出新增評鑑判決資料時" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, quality_score: 1, note: "xxxxx", appeal_judge: false } }
      subject { post "/lawyer/score/verdicts", verdict_score: params }

      it "Then 結果失敗" do
        expect { subject }.not_to change { lawyer.verdict_scores.count }
      end
    end

    context "When 到編輯判決評鑑頁面時" do
      subject! { get "/lawyer/score/verdicts/#{verdict_score.id}/edit" }

      it "Then 頁面會被 redirect" do
        expect(response).to be_redirect
      end
    end

    context "When 送出編輯評鑑判決資料時" do
      let!(:params) { { quality_score: 2 } }
      subject! { put "/lawyer/score/verdicts/#{verdict_score.id}", verdict_score: params }

      it "Then 結果失敗" do
        expect(verdict_score.reload.quality_score).not_to eq(2)
      end
    end
  end

end
