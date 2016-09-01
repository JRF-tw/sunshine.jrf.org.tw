require "rails_helper"
describe "判決評鑑法官輸入", type: :request do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:judge) { create :judge, court: court }
  let!(:judge2) { create :judge, court: court }
  let!(:verdict) { create :verdict, story: story, main_judge: judge, is_judgment: true }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name } }
  before { signin_lawyer(lawyer) }

  context "Given 案件已有判決日" do
    before { story.update_attributes(adjudge_date: Time.zone.today) }

    context "When 輸入正確的法官姓名" do
      subject! { post "/lawyer/score/verdicts/checked_judge", verdict_score: params }

      it "Then 進入評鑑頁" do
        expect(response).to be_success
        expect(flash[:error]).to be_nil
        expect(response.body).to match("裁判品質評分")
      end
    end

    context "When 法官姓名空白" do
      before { params[:judge_name] = "" }
      subject! { post "/lawyer/score/verdicts/checked_judge", verdict_score: params }

      it "Then 顯示法官輸入頁，和錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("法官為必填")
      end
    end

    context "When 輸入判決書上非主審法官的名字" do
      before { params[:judge_name] = judge2.name }
      subject! { post "/lawyer/score/verdicts/checked_judge", verdict_score: params }

      it "Then 顯示法官輸入頁，和錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("判決書比對法官名稱錯誤")
      end
    end

    context "When 輸入不存在的法官姓名" do
      before { params[:judge_name] = "xzcxcz" }
      subject! { post "/lawyer/score/verdicts/checked_judge", verdict_score: params }

      it "Then 顯示法官輸入頁，保留原先輸入的法官姓名，並且錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("法官不存在")
      end
    end
  end
end
