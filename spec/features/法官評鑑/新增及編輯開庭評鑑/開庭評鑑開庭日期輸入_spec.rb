require "rails_helper"
describe "法官評鑑 - 新增及編輯開庭評鑑 - 開庭評鑑開庭日期輸入", type: :request do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:schedule) { create :schedule, story: story }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, start_on: schedule.start_on, confirmed_realdate: false } }
  before { signin_lawyer(lawyer) }

  context "Given 案件無宣判日， 「確認此日期為實際開庭日」不打勾" do
    context "When 送出過去日期，且庭期表有該日期" do
      let!(:in_past_schedule) { create :schedule, :date_is_yesterday, story: story }
      before { params[:start_on] = in_past_schedule.start_on }
      subject! { post "/lawyer/score/schedules/check_date", schedule_score: params }

      it "Then 跳轉至法官輸入頁，並顯示此筆案件的法院+年度+字號+案號+開庭日" do
        follow_redirect!
        expect(response).to be_success
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(in_past_schedule.start_on.to_s)
      end
    end

    context "When 送出當天，且庭期表有該日期" do
      subject! { post "/lawyer/score/schedules/check_date", schedule_score: params }

      it "Then 跳轉至法官輸入頁，並顯示此筆案件的法院+年度+字號+案號+開庭日" do
        follow_redirect!
        expect(response).to be_success
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(schedule.start_on.to_s)
      end
    end

    context "When 送出未來日期，且庭期表有該日期" do
      let!(:future_schedule) { create :schedule, :date_is_tomorrow, story: story }
      before { params[:start_on] = future_schedule.start_on }
      subject! { post "/lawyer/score/schedules/check_date", schedule_score: params }

      it "Then 顯示開庭日期輸入頁，保留原先輸入的日期，並顯示錯誤訊息" do
        follow_redirect!
        expect(response).to be_success
        expect(flash[:error]).to match("開庭日期不能為未來時間")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(future_schedule.start_on.to_s)
      end
    end

    context "When 送出過去日期，但庭期表沒有該日期" do
      before { params[:start_on] = Time.zone.today - 5.days }
      subject! { post "/lawyer/score/schedules/check_date", schedule_score: params }

      it "Then 顯示開庭日期輸入頁，保留原先輸入的日期，並顯示錯誤訊息" do
        follow_redirect!
        expect(response).to be_success
        expect(flash[:error]).to match("查無此庭期")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(params[:start_on].to_s)
      end
    end

    context "When 送出過去日期，庭期表有該日期，但已超過期限（律師：兩週內）" do
      let!(:out_score_inverval_schedule) { create :schedule, story: story, start_on: Time.zone.today - 15.days }
      before { params[:start_on] = out_score_inverval_schedule.start_on }
      subject! { post "/lawyer/score/schedules/check_date", schedule_score: params }

      it "Then 顯示開庭日期輸入頁，保留原先輸入的日期，並顯示錯誤訊息" do
        follow_redirect!
        expect(response).to be_success
        expect(flash[:error]).to match("已超過可評鑑時間")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(params[:start_on].to_s)
      end
    end

    context "When 送出過去日期，庭期表有該日期，但已超過期限（當事人：兩週內）" do
      let!(:party) { create :party, :already_confirmed }
      before { signin_party(party) }
      let!(:out_score_inverval_schedule) { create :schedule, story: story, start_on: Time.zone.today - 15.days }
      before { params[:start_on] = out_score_inverval_schedule.start_on }
      subject! { post "/party/score/schedules/check_date", schedule_score: params }

      it "Then 顯示開庭日期輸入頁，保留原先輸入的日期，並顯示錯誤訊息" do
        follow_redirect!
        expect(response).to be_success
        expect(flash[:error]).to match("已超過可評鑑時間")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(params[:start_on].to_s)
      end
    end

    context "When 送出過去日期，庭期表有該日期，但已超過期限（觀察者：3 日內）" do
      let!(:court_observer) { create :court_observer }
      before { signin_court_observer(court_observer) }
      let!(:out_score_inverval_schedule) { create :schedule, story: story, start_on: Time.zone.today - 4.days }
      before { params[:start_on] = out_score_inverval_schedule.start_on }
      subject! { post "/observer/score/schedules/check_date", schedule_score: params }

      it "Then 顯示開庭日期輸入頁，保留原先輸入的日期，並顯示錯誤訊息" do
        follow_redirect!
        expect(response).to be_success
        expect(flash[:error]).to match("已超過可評鑑時間")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(params[:start_on].to_s)
      end
    end
  end

  context "Given 案件無宣判日， 「確認此日期為實際開庭日」打勾" do
    before { params[:confirmed_realdate] = "true" }

    context "When 送出過去日期（前一天），但庭期表沒有該日期" do
      before { params[:start_on] = Time.zone.today - 1.day }
      subject! { post "/lawyer/score/schedules/check_date", schedule_score: params }

      it "Then 跳轉至法官輸入頁，並顯示此筆案件的法院+年度+字號+案號+開庭日" do
        follow_redirect!
        expect(response).to be_success
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(params[:start_on].to_s)
      end
    end

    context "When 送出過去日期，庭期表無該日期，但已超過期限（律師：兩週內）" do
      before { params[:start_on] = Time.zone.today - 15.days }
      subject! { post "/lawyer/score/schedules/check_date", schedule_score: params }

      it "Then 顯示開庭日期輸入頁，保留原先輸入的日期，並顯示錯誤訊息" do
        follow_redirect!
        expect(response).to be_success
        expect(flash[:error]).to match("已超過可評鑑時間")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(params[:start_on].to_s)
      end
    end

    context "When 送出過去日期，庭期表無該日期，但已超過期限（當事人：兩週內）" do
      let!(:party) { create :party, :already_confirmed }
      before { signin_party(party) }
      before { params[:start_on] = Time.zone.today - 15.days }
      subject! { post "/party/score/schedules/check_date", schedule_score: params }

      it "Then 顯示開庭日期輸入頁，保留原先輸入的日期，並顯示錯誤訊息" do
        follow_redirect!
        expect(response).to be_success
        expect(flash[:error]).to match("已超過可評鑑時間")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(params[:start_on].to_s)
      end
    end

    context "When 送出過去日期，庭期表無該日期，但已超過期限（觀察者：3 日內）" do
      let!(:court_observer) { create :court_observer }
      before { signin_court_observer(court_observer) }
      before { params[:start_on] = Time.zone.today - 4.days }
      subject! { post "/observer/score/schedules/check_date", schedule_score: params }
      it "Then 顯示開庭日期輸入頁，保留原先輸入的日期，並顯示錯誤訊息" do
        follow_redirect!
        expect(response).to be_success
        expect(flash[:error]).to match("已超過可評鑑時間")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(params[:start_on].to_s)
      end
    end
  end
end
