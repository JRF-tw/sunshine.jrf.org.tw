require "rails_helper"
describe "法官評鑑 - 新增及編輯判決評鑑 - 判決評鑑的案件輸入", type: :request do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
  before { signin_lawyer(lawyer) }

  context "Given 案件已有判決日" do
    before { story.update_attributes(adjudge_date: Time.zone.today) }

    context "When 輸入完整案件資訊" do
      subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

      it "Then 跳轉至輸入法官姓名頁，並顯示此筆案件的法院+年度+字號+案號" do
        expect(response).to be_success
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
      end
    end

    context "When 輸入不存在的案件資訊" do
      before { params[:word_type] = "xxxx" }
      subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

      it "Then 到案件輸入頁，保留原始輸入資訊，顯示錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("案件不存在")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(params[:word_type])
        expect(response.body).to match(story.number.to_s)
      end
    end

    context "When 輸入案件資料任一選項空白" do
      before { params[:word_type] = "" }
      subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

      it "Then 到案件輸入頁，保留原始輸入資訊，顯示錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("字號不能為空")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(params[:word_type])
        expect(response.body).to match(story.number.to_s)
      end
    end
    context "When 登出，且完整輸入該案件資料" do
      before { signout_lawyer }
      subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

      it "Then 跳轉至登入頁面" do
        expect(response).to redirect_to("/lawyer/sign_in")
      end
    end
  end

  context "Given 案件已宣判，但尚未抓到判決書" do
    before { story.update_attributes(pronounce_date: Time.zone.today) }

    context "When 輸入完整案件資訊" do
      subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

      it "Then 到案件輸入頁，保留原始輸入資訊，顯示錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("尚未抓到判決書")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(params[:word_type])
        expect(response.body).to match(story.number.to_s)
      end
    end
  end

  context "Given 案件已有判決日，但超過判決期限（三個月）" do
    before { story.update_attributes(adjudge_date: Time.zone.today - 91.days) }

    context "When 輸入完整案件資訊" do
      subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

      it "Then 到案件輸入頁，保留原始輸入資訊，顯示錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("已超過可評鑑時間")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(params[:word_type])
        expect(response.body).to match(story.number.to_s)
      end
    end
  end
end
