require "rails_helper"
describe "開庭評鑑開庭日期輸入", type: :request do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:schedule) { create :schedule, story: story }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.date, confirmed_realdate: false } }
  before { signin_lawyer(lawyer) }

  context "Given 案件無宣判日， 「確認此日期為實際開庭日」不打勾" do
    context "When 送出過去日期，且庭期表有該日期" do
      let!(:in_past_schedule) { create :schedule, :date_is_yesterday, story: story }
      before { params[:date] = in_past_schedule.date }
      subject! { post "/lawyer/score/schedules/checked_date", schedule_score: params }

      it "Then 跳轉至法官輸入頁，並顯示此筆案件的法院+年度+字號+案號+開庭日" do
        expect(response).to be_success
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(in_past_schedule.date.to_s)
      end
    end

    context "When 送出當天，且庭期表有該日期" do
      subject! { post "/lawyer/score/schedules/checked_date", schedule_score: params }

      it "Then 跳轉至法官輸入頁，並顯示此筆案件的法院+年度+字號+案號+開庭日" do
        expect(response).to be_success
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(schedule.date.to_s)
      end
    end

    context "When 送出未來日期，且庭期表有該日期" do
      let!(:future_schedule) { create :schedule, :date_is_tomorrow, story: story }
      before { params[:date] = future_schedule.date }
      subject! { post "/lawyer/score/schedules/checked_date", schedule_score: params }

      it "Then 顯示開庭日期輸入頁，保留原先輸入的日期，並顯示錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("開期日期不能為未來時間")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(future_schedule.date.to_s)
      end
    end

    context "When 送出過去日期，但庭期表沒有該日期" do
      before { params[:date] = Time.zone.today - 5.days }
      subject! { post "/lawyer/score/schedules/checked_date", schedule_score: params }

      it "Then 顯示開庭日期輸入頁，保留原先輸入的日期，並顯示錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("庭期比對失敗")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(params[:date].to_s)
      end
    end

    context "When 送出過去日期，庭期表有該日期，但已超過期限（律師：兩週內）" do
      let!(:out_score_inverval_schedule) { create :schedule, story: story, date: Time.zone.today - 15.days }
      before { params[:date] = out_score_inverval_schedule.date }
      subject! { post "/lawyer/score/schedules/checked_date", schedule_score: params }

      it "Then 顯示開庭日期輸入頁，保留原先輸入的日期，並顯示錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("已超過可評鑑時間")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(params[:date].to_s)
      end
    end

    context "When 送出過去日期，庭期表有該日期，但已超過期限（當事人：兩週內）" do
      let!(:party) { create :party, :already_confirmed }
      before { signin_party(party) }
      let!(:out_score_inverval_schedule) { create :schedule, story: story, date: Time.zone.today - 15.days }
      before { params[:date] = out_score_inverval_schedule.date }
      subject! { post "/party/score/schedules/checked_date", schedule_score: params }

      it "Then 顯示開庭日期輸入頁，保留原先輸入的日期，並顯示錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("已超過可評鑑時間")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(params[:date].to_s)
      end
    end

    context "When 送出過去日期，庭期表有該日期，但已超過期限（觀察者：3 日內）" do
      let!(:court_observer) { create :court_observer }
      before { signin_court_observer(court_observer) }
      let!(:out_score_inverval_schedule) { create :schedule, story: story, date: Time.zone.today - 4.days }
      before { params[:date] = out_score_inverval_schedule.date }
      subject! { post "/observer/score/schedules/checked_date", schedule_score: params }

      it "Then 顯示開庭日期輸入頁，保留原先輸入的日期，並顯示錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("已超過可評鑑時間")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(params[:date].to_s)
      end
    end
  end

  context "Given 案件無宣判日， 「確認此日期為實際開庭日」打勾" do
    before { params[:confirmed_realdate] = "true" }

    context "When 送出過去日期（前一天），但庭期表沒有該日期" do
      before { params[:date] = Time.zone.today - 1.day }
      subject! { post "/lawyer/score/schedules/checked_date", schedule_score: params }

      it "Then 跳轉至法官輸入頁，並顯示此筆案件的法院+年度+字號+案號+開庭日" do
        expect(response).to be_success
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(params[:date].to_s)
      end
    end

    context "When 送出過去日期，庭期表無該日期，但已超過期限（律師：兩週內）" do
      before { params[:date] = Time.zone.today - 15.days }
      subject! { post "/lawyer/score/schedules/checked_date", schedule_score: params }

      it "Then 顯示開庭日期輸入頁，保留原先輸入的日期，並顯示錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("已超過可評鑑時間")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(params[:date].to_s)
      end
    end

    context "When 送出過去日期，庭期表無該日期，但已超過期限（當事人：兩週內）" do
      let!(:party) { create :party, :already_confirmed }
      before { signin_party(party) }
      before { params[:date] = Time.zone.today - 15.days }
      subject! { post "/party/score/schedules/checked_date", schedule_score: params }

      it "Then 顯示開庭日期輸入頁，保留原先輸入的日期，並顯示錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("已超過可評鑑時間")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(params[:date].to_s)
      end
    end

    context "When 送出過去日期，庭期表無該日期，但已超過期限（觀察者：3 日內）" do
      let!(:court_observer) { create :court_observer }
      before { signin_court_observer(court_observer) }
      before { params[:date] = Time.zone.today - 4.days }
      subject! { post "/observer/score/schedules/checked_date", schedule_score: params }
      it "Then 顯示開庭日期輸入頁，保留原先輸入的日期，並顯示錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to match("已超過可評鑑時間")
        expect(response.body).to match(story.court.full_name)
        expect(response.body).to match(story.year.to_s)
        expect(response.body).to match(story.word_type)
        expect(response.body).to match(story.number.to_s)
        expect(response.body).to match(params[:date].to_s)
      end
    end
  end
end
