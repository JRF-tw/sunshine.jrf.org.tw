require "rails_helper"
describe "開庭評鑑案件輸入", type: :request do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, :adjudged, court: court }
  let!(:judge) { create :judge, court: court }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, quality_score: 1, note: "xxxxx", appeal_judge: false } }
  before { signin_lawyer(lawyer) }

  context "Given 案件已有判決日，且為新增評鑑" do
    context "When 送出評鑑資料" do
      subject! { post "/lawyer/score/verdicts", verdict_score: params }

      it "成功新增，轉跳至感謝頁" do
        expect(response).to be_redirect
        follow_redirect!
        expect(response.body).to match("感謝您的評鑑")
      end
    end

    context "When 送出星星數未填的資料" do
      before { params[:quality_score] = "" }
      subject! { post "/lawyer/score/verdicts", verdict_score: params }

      it "失敗新增，顯示評鑑輸入頁，保留先輸入的資料" do
        expect(response).to be_success
        expect(response.body).to match(params[:note])
      end
    end
  end

  context "Given 案件已有判決日，且為更新評鑑" do
    let!(:params) { { quality_score: 5 } }
    let!(:verdict_score) { create :verdict_score, verdict_rater: lawyer, story: story, court_id: court.id }
    subject! { put "/lawyer/score/verdicts/#{verdict_score.id}", verdict_score: params }

    context "When 送出評鑑資料" do
      it "成功更新，轉跳至感謝頁面" do
        expect(response).to be_redirect
        follow_redirect!
        expect(response.body).to match("感謝您的評鑑")
      end
    end
  end
end
