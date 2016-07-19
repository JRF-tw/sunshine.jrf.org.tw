require "rails_helper"

describe "當事人忘記密碼", type: :request do
  context "忘記密碼" do
    let!(:party) { FactoryGirl.create :party }

    context "成功送出" do
      let!(:params) { { identify_number: party.identify_number, phone_number: party.phone_number } }
      subject { post "/party/password", party: params }

      it "發送重設密碼簡訊" do
        expect { subject }.to change_sidekiq_jobs_size_of(SmsService, :send_to)
      end

      it "回到登入頁" do
        expect(subject).to redirect_to("/party/sign_in")
      end
    end

    context "失敗送出" do
      context "超過簡訊發送限制" do
        let!(:party) { party_with_sms_send_count(2) }
        let!(:params) { { identify_number: party.identify_number, phone_number: party.phone_number } }
        subject! { post "/party/password", party: params }

        it "連續發送 2 次後，達限制上限" do
          expect(response.body).to match("五分鐘內只能寄送兩次簡訊")
        end
      end

      context "手機號碼未驗證" do
        let!(:party) { party_with_unconfirm_phone_number("0911828181") }
        subject! { post "/party/password", party: { identify_number: party.identify_number, phone_number: "0911828181" } }

        it "顯示錯誤訊息，並提示可進行人工申訴" do
          expect(response.body).to match("手機號碼尚未驗證 <a href='/party/appeal/new'>人工申訴</a>")
        end
      end

      context "驗證錯誤" do
        context "手機號碼存在，ID 不存在" do
          subject! { post "/party/password", party: { identify_number: "F123456789", phone_number: party.phone_number } }

          it "顯示無此當事人資訊" do
            expect(response.body).to match("沒有此當事人資訊")
          end
        end

        context "手機號碼不存在，ID 存在" do
          subject! { post "/party/password", party: { identify_number: party.identify_number, phone_number: "0911111111" } }

          it "顯示手機號碼錯誤" do
            expect(response.body).to match("手機號碼輸入錯誤")
          end
        end

        context "手機號碼不存在，ID 不存在" do
          subject! { post "/party/password", party: { identify_number: "F123456789", phone_number: "0911111111" } }

          it "顯示無此當事人資訊" do
            expect(response.body).to match("沒有此當事人資訊")
          end
        end
      end

      context "輸入內容錯誤" do
        context "ID空白" do
          subject! { post "/party/password", party: { identify_number: "", phone_number: party.phone_number } }

          it "顯示無此當事人資訊" do
            expect(response.body).to match("沒有此當事人資訊")
          end
        end

        context "手機號碼空白" do
          subject! { post "/party/password", party: { identify_number: party.identify_number, phone_number: "" } }

          it "顯示手機號碼錯誤" do
            expect(response.body).to match("手機號碼輸入錯誤")
          end
        end

        context "ID + 手機號碼皆空白" do
          subject! { post "/party/password", party: { identify_number: "", phone_number: "" } }

          it "顯示無此當事人資訊" do
            expect(response.body).to match("沒有此當事人資訊")
          end
        end
      end
    end
  end
end
