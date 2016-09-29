require "rails_helper"
describe "法官評鑑 - 新增及編輯開庭評鑑 - 開庭評鑑輸入", type: :request do
  let!(:story) { create(:story) }
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:schedule) { create :schedule, story: story }
  let!(:judge) { create :judge, court: court }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, start_on: schedule.start_on, confirmed_realdate: false, judge_name: judge.name, command_score: 1, attitude_score: 1, note: "xxxxx", appeal_judge: false } }
  before { signin_lawyer(lawyer) }

  context "Given 案件無宣判日，且為新增評鑑" do
    context "When 送出評鑑資料" do
      subject! { post "/lawyer/score/schedules", schedule_score: params }

      it "Then 成功新增，轉跳至感謝頁" do
        expect(response).to be_success
        expect(response.body).to match("感謝您的評鑑")
        expect(lawyer.schedule_scores.count).to eq(1)
      end
    end

    context "When 送出星星數未填的資料（律師必填開庭滿意度）" do
      before { params[:attitude_score] = "" }
      subject! { post "/lawyer/score/schedules", schedule_score: params }

      it "Then 失敗新增，顯示評鑑輸入頁，保留先輸入的資料" do
        follow_redirect!
        expect(response).to be_success
        expect(flash[:error]).to match("開庭滿意度分數為必填")
        expect(response.body).to match(params[:note])
      end
    end

    context "When 送出星星數未填的資料（律師必填訴訟指揮）" do
      before { params[:command_score] = "" }
      subject! { post "/lawyer/score/schedules", schedule_score: params }

      it "Then 失敗新增，顯示評鑑輸入頁，保留先輸入的資料" do
        follow_redirect!
        expect(response).to be_success
        expect(flash[:error]).to match("訴訟指揮分數為必填")
        expect(response.body).to match(params[:note])
      end
    end

    context "When 送出星星數未填的資料（觀察者必填開庭滿意度）" do
      let!(:court_observer) { create :court_observer }
      before { params[:rating_score] = "" }
      before { signin_court_observer(court_observer) }
      subject! { post "/observer/score/schedules", schedule_score: params }

      it "Then 失敗新增，顯示評鑑輸入頁，保留先輸入的資料" do
        expect(response).to be_success
        expect(flash[:error]).to match("開庭滿意度分數為必填")
        expect(response.body).to match(params[:note])
      end
    end

    context "When 送出星星數未填的資料（當事人必填開庭滿意度）" do
      let!(:party) { create :party, :already_confirmed }
      before { params[:rating_score] = "" }
      before { signin_party(party) }
      subject! { post "/party/score/schedules", schedule_score: params }

      it "Then 失敗新增，顯示評鑑輸入頁，保留先輸入的資料" do
        follow_redirect!
        expect(response).to be_success
        expect(flash[:error]).to match("開庭滿意度分數為必填")
        expect(response.body).to match(params[:note])
      end
    end
  end

  context "Given 案件無宣判日，且為更新評鑑" do
    let!(:params) { { command_score: 5, attitude_score: 5 } }
    let!(:schedule_score) { create :schedule_score, schedule_rater: lawyer, court_id: court.id }
    subject! { put "/lawyer/score/schedules/#{schedule_score.id}", schedule_score: params }

    context "When 送出評鑑資料" do
      it "Then 成功更新，轉跳至感謝頁面" do
        expect(response.body).to match("感謝您的評鑑")
        expect(schedule_score.reload.command_score).to eq(params[:command_score])
      end
    end
  end
end
