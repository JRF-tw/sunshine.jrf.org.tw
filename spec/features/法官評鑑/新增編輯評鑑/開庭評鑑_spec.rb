require "rails_helper"
describe "新增編輯評鑑 - 開庭評鑑", type: :request do
  let!(:story) { create(:story) }
  let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:schedule) { create :schedule, story: story }
  let!(:judge) { create :judge, court: court }
  let!(:judge2) { create :judge }
  before { signin_lawyer(lawyer) }

  context "案件輸入頁" do
    context "成功送出" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }

      context "跳轉至輸入開庭日期頁，並顯示此筆案件的法院+年度+字號+案號" do
        subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

        it "顯示正確資訊" do
          expect(response.body).to match(story.court.full_name)
          expect(response.body).to match(story.year.to_s)
          expect(response.body).to match(story.word_type)
          expect(response.body).to match(story.number.to_s)
        end
      end

      context "案件已有宣判日，但尚未宣判" do
        before { story.update_attributes(pronounce_date: Time.zone.today, is_pronounce: false) }
        subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

        it "無錯誤訊息" do
          expect(response).to be_success
          expect(flash[:error]).to be_nil
        end
      end

      context "案件無宣判日" do
        before { story.update_attributes(pronounce_date: nil, is_pronounce: false) }
        subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

        it "無錯誤訊息" do
          expect(response).to be_success
          expect(flash[:error]).to be_nil
        end
      end
    end

    context "失敗送出" do
      context "法院+年度+字號+案號不存在" do
        let!(:params) { { court_id: court.id, year: story.year, word_type: "xxxx", number: story.number } }
        subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

        it "顯示案件不存在" do
          expect(flash[:error]).to match("案件不存在")
        end
      end

      context "任一選項空白" do
        let!(:params) { { court_id: court.id, year: "", word_type: "xxxx", number: story.number } }
        subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

        it "顯示錯誤訊息" do
          expect(flash[:error]).to match("年份不能為空")
        end
      end

      context "案件已宣判" do
        context "已知類型為「宣判」的開庭日，且目前時間已超過宣判日" do
          before { story.update_attributes(pronounce_date: Time.zone.today - 1.day, is_pronounce: true) }
          let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
          subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

          it "顯示錯誤訊息" do
            expect(flash[:error]).to match("案件已宣判")
          end
        end

        context "已抓到判決書" do
          before { story.update_attributes(adjudge_date: Time.zone.today) }
          let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
          subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

          it "顯示錯誤訊息" do
            expect(flash[:error]).to match("已有判決書")
          end
        end
      end

      context "提交表單時未登入" do
        before { signout_lawyer }
        let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number } }
        subject! { post "/lawyer/score/schedules/checked_info", schedule_score: params }

        it "導回登入頁" do
          expect(response).to be_redirect
        end
      end

      xit "使用者被封鎖評鑑功能"
    end
  end

  context "開庭日期輸入頁" do
    context "成功送出" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.date, confirmed_realdate: false } }

      context "跳轉至法官輸入頁，並顯示此筆案件的法院+年度+字號+案號+開庭日" do
        subject! { post "/lawyer/score/schedules/checked_date", schedule_score: params }

        it "顯示正確資訊" do
          expect(response.body).to match(story.court.full_name)
          expect(response.body).to match(story.year.to_s)
          expect(response.body).to match(story.word_type)
          expect(response.body).to match(story.number.to_s)
          expect(response.body).to match(schedule.date.to_s)
        end
      end

      context "確認此日期為實際開庭日（預設不打勾）" do
        context "不打勾" do
          context "進行開庭日和庭期表的比對與關聯" do
            subject! { post "/lawyer/score/schedules/checked_date", schedule_score: params }

            it "成功" do
              subject
              expect(response).to be_success
              expect(flash[:error]).to be_nil
            end
          end
        end

        context "打勾（用於庭期表與實際開庭日不同)" do
          before { params[:confirmed_realdate] = "true" }
          before { params[:date] = schedule.date - 3.days }

          context "不進行開庭日和庭期表的比對，直接允許評鑑" do
            subject! { post "/lawyer/score/schedules/checked_date", schedule_score: params }

            it "成功" do
              expect(response).to be_success
              expect(flash[:error]).to be_nil
            end
          end

          context "同一帳號下，打勾的評鑑滿 5 個時" do
            before { lawyer.score_report_schedule_real_date.value = 4 }
            subject { post "/lawyer/score/schedules/checked_date", schedule_score: params }

            it "slack 通知" do
              expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify)
            end

            xit "即鎖住無法再進行有打勾的評鑑（只能進行不打勾的）" do
              xit "從後台解鎖後，就可以再進行打勾的評鑑"
            end
          end
        end
      end
    end

    context "失敗送出" do
      let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.date, confirmed_realdate: false } }

      context "開庭日在未來" do
        before { params[:date] = Time.zone.today + 1.day }
        subject! { post "/lawyer/score/schedules/checked_date", schedule_score: params }

        it "顯示錯誤訊息" do
          expect(flash[:error]).to match("開期日期不能為未來時間")
        end
      end

      context "進行庭期表比對後比對不到" do
        before { params[:date] = schedule.date - 1.day }
        subject! { post "/lawyer/score/schedules/checked_date", schedule_score: params }

        it "顯示錯誤訊息" do
          expect(flash[:error]).to match("庭期比對失敗")
        end
      end

      xit "使用者被封鎖評鑑功能"

      xit "超過 5 次的不進行庭期表比對評鑑"

      context "超過評鑑開庭的期限" do
        context "律師：開庭日後兩週內" do
          before { schedule.update_attributes(date: Time.zone.today - 15.days) }
          before { params[:date] = schedule.date }
          subject! { post "/lawyer/score/schedules/checked_date", schedule_score: params }

          it "顯示錯誤訊息" do
            expect(flash[:error]).to match("已超過可評鑑時間")
          end
        end

        context "當事人：開庭日後兩週內" do
          let!(:party) { create :party, :already_confirmed }

          before do
            signout_lawyer
            signin_party(party)
            schedule.update_attributes(date: Time.zone.today - 15.days)
            params[:date] = schedule.date
          end

          subject! { post "/party/score/schedules/checked_date", schedule_score: params }

          it "顯示錯誤訊息" do
            expect(flash[:error]).to match("已超過可評鑑時間")
          end
        end

        context "觀察者：開庭日後 3 日內" do
          let!(:court_observer) { create :court_observer }

          before do
            signout_lawyer
            signin_court_observer(court_observer)
            schedule.update_attributes(date: Time.zone.today - 4.days)
            params[:date] = schedule.date
          end

          subject! { post "/observer/score/schedules/checked_date", schedule_score: params }

          it "顯示錯誤訊息" do
            expect(flash[:error]).to match("已超過可評鑑時間")
          end
        end
      end
    end
  end

  context "法官輸入頁" do
    let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.date, confirmed_realdate: false, judge_name: judge.name } }

    context "成功送出" do
      subject! { post "/lawyer/score/schedules/checked_judge", schedule_score: params }

      it "無錯誤訊息" do
        expect(response).to be_success
        expect(flash[:error]).to be_nil
      end
    end

    context "失敗送出" do
      context "輸入欄位空白" do
        before { params[:judge_name] = "" }
        subject! { post "/lawyer/score/schedules/checked_judge", schedule_score: params }

        it "顯示錯誤訊息" do
          expect(response).to be_redirect
          expect(flash[:error]).to match("法官姓名不能為空")
        end
      end

      context "該法官不隸屬該法院" do
        before { params[:judge_name] = judge2.name }
        subject! { post "/lawyer/score/schedules/checked_judge", schedule_score: params }

        it "顯示錯誤訊息" do
          expect(response).to be_redirect
          expect(flash[:error]).to match("法官不存在該法院")
        end
      end

      xit "使用者被封鎖評鑑功能"

      context "該法官不隸屬該法院" do
        before { params[:judge_name] = "MarsZ" }
        subject! { post "/lawyer/score/schedules/checked_judge", schedule_score: params }

        it "顯示錯誤訊息" do
          expect(response).to be_redirect
          expect(flash[:error]).to match("沒有該位法官")
        end
      end
    end
  end

  context "評鑑頁" do
    let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.date, confirmed_realdate: false, judge_name: judge.name, command_score: 1, attitude_score: 1, note: "xxxxx", appeal_judge: false } }
    context "新增" do
      context "成功" do
        context "新增評鑑資料" do
          subject { post "/lawyer/score/schedules", schedule_score: params }

          it "以建立評鑑" do
            expect { subject }.to change { lawyer.schedule_scores.count }
          end
        end
      end
    end

    context "失敗" do
      context "未選擇星星數" do
        let!(:party) { create :party, :already_confirmed }
        let!(:court_observer) { create :court_observer }

        context "律師必填訴訟指揮" do
          before { params[:command_score] = "" }
          subject! { post "/lawyer/score/schedules", schedule_score: params }

          it "顯示錯誤訊息" do
            expect(flash[:error]).to match("訴訟指揮分數為必填")
          end
        end

        context "律師必填開庭滿意度" do
          before { params[:attitude_score] = "" }
          subject! { post "/lawyer/score/schedules", schedule_score: params }

          it "顯示錯誤訊息" do
            expect(flash[:error]).to match("開庭滿意度分數為必填")
          end
        end

        context "觀察者必填開庭滿意度" do
          let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.date, confirmed_realdate: false, judge_name: judge.name, rating_score: 1, note: "xxxxx", appeal_judge: false } }
          before do
            signout_lawyer
            signin_court_observer(court_observer)
            params[:rating_score] = ""
          end
          subject! { post "/observer/score/schedules", schedule_score: params }

          it "顯示錯誤訊息" do
            expect(flash[:error]).to match("開庭滿意度分數為必填")
          end
        end

        context "當事人必填開庭滿意度" do
          let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.date, confirmed_realdate: false, judge_name: judge.name, rating_score: 1, note: "xxxxx", appeal_judge: false } }
          before do
            signout_lawyer
            signin_party(party)
            params[:rating_score] = ""
          end

          subject! { post "/party/score/schedules", schedule_score: params }

          it "顯示錯誤訊息" do
            expect(flash[:error]).to match("開庭滿意度分數為必填")
          end
        end
      end

      xit "使用者被封鎖評鑑功能"
    end

    xit "編輯"
  end

  context "評鑑後感謝頁" do
    let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.date, confirmed_realdate: false, judge_name: judge.name, command_score: 1, attitude_score: 1, note: "xxxxx", appeal_judge: false } }
    subject! { post "/lawyer/score/schedules", schedule_score: params }

    it "成功讀取" do
      expect(response).to be_success
      expect(response.body).to match("感謝您的評鑑")
    end
  end
end
