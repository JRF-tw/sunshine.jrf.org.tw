require "rails_helper"
describe "法官評鑑 - 新增及編輯開庭評鑑 - 開庭評鑑案件輸入", type: :request do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
  before { signin_lawyer(lawyer) }

  context "Given 案件有宣判日，但尚未宣判（日期在未來）" do
    before { story.update_attributes(pronounce_date: Time.zone.today, is_pronounce: false) }

    context "When 完整輸入該案件資料" do
      subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

      it "Then 成功找到該案件，顯示日期輸入頁，並且顯示此筆案件的法院+年度+字號+案號" do
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
      end
    end
  end

  context "Given 案件有宣判日，但宣判日在過去" do
    before { story.update_attributes(pronounce_date: Time.zone.today - 3.days, is_pronounce: true) }

    context "When 完整輸入該案件資料" do
      subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

      it "Then 顯示前頁內容 + 錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("案件已宣判")
      end
    end
  end

  context "Given 案件有判決日（已抓到判決書）" do
    before { story.update_attributes(adjudge_date: Time.zone.today) }

    context "When 完整輸入該案件資料" do
      subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

      it "Then 顯示前頁內容 + 錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("已有判決書")
      end
    end
  end

  context "Given 案件無宣判日" do
    before { story.update_attributes(pronounce_date: nil) }

    context "When 完整輸入該案件資料" do
      subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

      it "Then 成功找到該案件，顯示日期輸入頁，並且顯示此筆案件的法院+年度+字號+案號" do
        expect(response).to be_success
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
      end
    end

    context "When 輸入不存在的案件資料" do
      before { params[:word_type] = "xxx" }
      subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

      it "Then 顯示前頁內容 + 錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("案件不存在")
      end
    end

    context "When 案件資料任一選項空白" do
      before { params[:year] = "" }
      subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

      it "Then 顯示前頁內容 + 錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("年份不能為空")
      end
    end

    context "When 登出，且完整輸入該案件資料" do
      before { signout_lawyer }
      subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

      it "Then 轉跳至登入頁" do
        expect(response).to redirect_to("/lawyer/sign_in")
      end
    end
  end
end
