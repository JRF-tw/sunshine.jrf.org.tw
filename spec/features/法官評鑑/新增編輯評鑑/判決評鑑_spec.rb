require "rails_helper"
describe "新增編輯評鑑 - 判決評鑑", type: :request do
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, :pronounced, :adjudged, court: court }
  let!(:judge) { create :judge, court: court }
  before { signin_lawyer(lawyer) }

  context "觀察者無法評鑑判決（404)" do
    let!(:court_observer) { create :court_observer }

    before do
      signout_lawyer
      signin_court_observer(court_observer)
    end
    subject! { get "/observer/score/verdicts/new" }

    it "404 page" do
      expect(response.status).to eq(404)
    end
  end

  context "案件輸入頁" do
    let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
    context "成功送出" do
      subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

      context "跳轉至輸入開庭日期頁，並顯示此筆案件的法院+年度+字號+案號" do
        it "顯示對應資訊" do
          expect(response.body).to match(story.court.full_name)
          expect(response.body).to match(story.year.to_s)
          expect(response.body).to match(story.word_type)
          expect(response.body).to match(story.number.to_s)
        end
      end

      context "已抓到判決書" do
        before { story.update_attributes(is_adjudge: true) }

        it "無錯誤訊息" do
          expect(response).to be_success
          expect(flash[:error]).to be_nil
        end
      end
    end

    context "失敗送出" do
      context "法院+年度+字號+案號不存在" do
        before { params[:word_type] = "xxx" }
        subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

        it "顯示錯誤訊息" do
          expect(flash[:error]).to match("案件不存在")
        end
      end

      context "任一選項空白" do
        before { params[:word_type] = "" }
        subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

        it "顯示錯誤訊息" do
          expect(flash[:error]).to match("字號不能為空")
        end
      end

      context "尚未抓到判決書" do
        before { story.update_attributes(is_adjudge: false) }
        subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

        it "顯示錯誤訊息" do
          expect(flash[:error]).to match("尚未抓到判決書")
        end
      end

      context "提交表單時未登入" do
        before { signout_lawyer }
        subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

        it "被帶回登入頁" do
          expect(response).to be_redirect
        end
      end

      xit "使用者被封鎖評鑑功能"

      context "超過判決評鑑期限" do
        before { story.update_attributes(is_adjudge: true, adjudge_date: Time.zone.today - 91.days) }
        subject! { post "/lawyer/score/verdicts/checked_info", verdict_score: params }

        context "抓到判決書後三個月" do
          it "顯示錯誤訊息" do
            expect(flash[:error]).to match("已超過可評鑑時間")
          end
        end
      end
    end
  end

  context "法官輸入頁" do
    let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name } }
    context "成功送出" do
      subject! { post "/lawyer/score/verdicts/checked_judge", verdict_score: params }

      context "進入評鑑頁" do
        it "無錯誤訊息, 並且顯示評鑑頁內容" do
          expect(response).to be_success
          expect(flash[:error]).to be_nil
          expect(response.body).to match("裁判品質評分")
        end
      end
    end

    context "失敗送出" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name } }

      context "輸入欄位空白" do
        before { params[:judge_name] = "" }
        subject! { post "/lawyer/score/verdicts/checked_judge", verdict_score: params }

        it "顯示錯誤訊息" do
          expect(flash[:error]).to match("法官為必填")
        end
      end

      context "該法官不在判決書內" do
        let!(:verdict) { create :verdict, story: story, main_judge: judge, is_judgment: true }
        before { params[:judge_name] = "xxxx" }
        subject! { post "/lawyer/score/verdicts/checked_judge", verdict_score: params }

        it "顯示錯誤訊息" do
          expect(flash[:error]).to match("判決書比對法官名稱錯誤")
        end
      end

      xit "使用者被封鎖評鑑功能"
    end
  end

  context "評鑑頁" do
    context "新增" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, quality_score: 1, note: "xxxxx", appeal_judge: false } }
      context "成功" do
        subject { post "/lawyer/score/verdicts", verdict_score: params }

        it "跳到感謝頁面" do
          subject
          expect(response).to be_success
          expect(response.body).to match("感謝您的評鑑")
        end

        it "新增判決評鑑資料" do
          expect { subject }.to change { lawyer.verdict_scores.reload.count }
        end
      end

      context "失敗" do
        context "未選擇星星數" do
          before { params[:quality_score] = "" }
          subject! { post "/lawyer/score/verdicts", verdict_score: params }

          it "顯示錯誤訊息" do
            expect(flash[:error]).to match("裁判品質為必填")
          end
        end

        xit "使用者被封鎖評鑑功能"
      end
    end

    xit "編輯"
  end

  context "評鑑後感謝頁" do
    context "成功讀取" do
    end
  end
end
