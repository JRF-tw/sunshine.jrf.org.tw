require "rails_helper"
describe "法官評鑑 - 新增及編輯開庭評鑑 - 開庭評鑑法官輸入", type: :request do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:schedule) { create :schedule, story: story }
  let!(:judge) { create :judge, court: court }
  let!(:judge2) { create :judge }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, start_on: schedule.start_on, confirmed_realdate: false, judge_name: judge.name } }
  before { signin_lawyer(lawyer) }

  context "Given 案件無宣判日" do
    context "When 輸入正確的法官姓名" do
      subject! { post "/lawyer/score/schedules/check_judge", schedule_score: params }

      it "Then 進入評鑑頁" do
        follow_redirect!
        expect(response).to be_success
        expect(response.body).to match("送出評鑑")
      end
    end

    context "When 輸入已經評鑑過同一庭期的法官姓名" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, start_on: schedule.start_on, confirmed_realdate: false, judge_name: judge.name, command_score: 1, attitude_score: 1, note: "xxxxx", appeal_judge: false } }
      before { post "/lawyer/score/schedules", schedule_score: params }
      subject! { post "/lawyer/score/schedules/check_judge", schedule_score: params }

      it "Then 顯示法官輸入頁，和錯誤訊息" do
        follow_redirect!
        expect(response.body).to match("輸入法官姓名")
        expect(flash[:error]).to match("已評鑑過該法官")
      end
    end

    context "When 法官姓名空白" do
      before { params[:judge_name] = "" }
      subject! { post "/lawyer/score/schedules/check_judge", schedule_score: params }

      it "Then 顯示法官輸入頁，和錯誤訊息" do
        follow_redirect!
        expect(response).to be_success
        expect(flash[:error]).to match("法官姓名不能為空")
      end
    end

    context "When 輸入不隸屬於該法院的法官姓名" do
      before { params[:judge_name] = judge2.name }
      subject! { post "/lawyer/score/schedules/check_judge", schedule_score: params }

      it "Then 顯示法官輸入頁，保留原先輸入的法官姓名，並且錯誤訊息" do
        follow_redirect!
        expect(response).to be_success
        expect(flash[:error]).to match("法官不存在該法院")
        expect(response.body).to match(params[:judge_name])
      end
    end

    context "When 輸入不存在的法官姓名" do
      before { params[:judge_name] = "unexist_judge_name" }
      subject! { post "/lawyer/score/schedules/check_judge", schedule_score: params }

      it "Then 顯示法官輸入頁，保留原先輸入的法官姓名，並且錯誤訊息" do
        follow_redirect!
        expect(response).to be_success
        expect(flash[:error]).to match("沒有該位法官")
        expect(response.body).to match(params[:judge_name])
      end
    end
  end
end
