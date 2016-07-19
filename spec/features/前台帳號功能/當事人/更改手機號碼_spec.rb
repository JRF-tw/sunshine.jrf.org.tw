require "rails_helper"

describe "當事人更改手機號碼", type: :request do
  context "手機號碼輸入頁" do
    context "成功送出" do
      before { signin_party }
      subject { put "/party/phone", party: { phone_number: "0911111111" } }

      it "轉跳至認證碼輸入頁" do
        expect(subject).to redirect_to("/party/phone/verify")
      end

      it "發送簡訊" do
        expect { subject }.to change_sidekiq_jobs_size_of(SmsService, :send_to)
      end
    end

    context "失敗送出" do
      let!(:party) { FactoryGirl.create :party }

      context "該手機號碼已被別人驗證" do
        before { signin_party }
        subject! { put "/party/phone", party: { phone_number: party.phone_number } }

        it "提示號碼已經被使用" do
          expect(response.body).to match("該手機號碼已註冊")
        end
      end

      context "該手機號碼正在被別人驗證中" do
        before { party_with_unconfirm_phone_number("0911111111") }
        before { signin_party }
        subject! { put "/party/phone", party: { phone_number: "0911111111" } }

        it "提示號碼已經被使用" do
          expect(response.body).to match("該手機號碼正等待驗證中")
        end
      end

      context "該手機號碼跟原本的一樣" do
        before { signin_party(party) }
        subject! { put "/party/phone", party: { phone_number: party.phone_number } }

        it "提示號碼已經被使用" do
          expect(response.body).to match("手機號碼不可與原本相同")
        end
      end

      context "目前已超過簡訊發送限制" do
        context "連續成功送出更改手機號碼的認證簡訊（每次都不同號碼），使其達到上限" do
          before { signin_party }
          before { party_chang_phone_number_times(3) }

          it "提示五分鐘只能寄送兩次" do
            expect(response.body).to match("五分鐘內只能寄送兩次簡訊")
          end
        end

        context "連續發送忘記密碼簡訊，使其達到上限" do
          let!(:party) { party_with_sms_send_count(2) }
          let!(:params) { { identify_number: party.identify_number, phone_number: party.phone_number } }
          subject! { post "/party/password", party: params }

          it "連續發送 2 次後，達限制上限" do
            expect(response.body).to match("五分鐘內只能寄送兩次簡訊")
          end
        end

        context "連續發送忘記密碼和更改手機號碼簡訊，使其達到上限" do
          before { post "/party/password", party: { identify_number: party.identify_number, phone_number: party.phone_number } }
          before { signin_party(party) }
          before { put "/party/phone", party: { phone_number: "0911111111" } }
          subject! { put "/party/phone", party: { phone_number: "0911111112" } }

          it "提示五分鐘只能寄送兩次" do
            expect(response.body).to match("五分鐘內只能寄送兩次簡訊")
          end
        end
      end

      context "號碼格式不符" do
        before { signin_party }

        context "空白" do
          subject! { put "/party/phone", party: { phone_number: "" } }

          it "提示手機號碼不可為空" do
            expect(response.body).to match("手機號碼為必填欄位")
          end
        end

        context "過長" do
          subject! { put "/party/phone", party: { phone_number: "091111111111" } }

          it "提示手機號碼格式不符" do
            expect(response.body).to match("手機號碼格式錯誤")
          end
        end

        context "過短" do
          subject! { put "/party/phone", party: { phone_number: "0911" } }

          it "提示手機號碼格式不符" do
            expect(response.body).to match("手機號碼格式錯誤")
          end
        end

        context "非09開頭" do
          subject! { put "/party/phone", party: { phone_number: "0811111111" } }

          it "提示手機號碼格式不符" do
            expect(response.body).to match("手機號碼格式錯誤")
          end
        end

        context "非全數字" do
          subject! { put "/party/phone", party: { phone_number: "091111a111" } }

          it "提示手機號碼格式不符" do
            expect(response.body).to match("手機號碼格式錯誤")
          end
        end
      end
    end
  end

  context "認證碼輸入頁" do
    let(:party) { FactoryGirl.create :party }
    before { signin_party(party) }
    context "在當事人手機驗證流程已測過" do
    end

    context "成功驗證" do
      before { put "/party/phone", party: { phone_number: "0911111111" } }
      subject { put "/party/phone/verifing", party: { phone_varify_code: party.phone_varify_code.value } }

      it "確實更改了當事人的手機號碼" do
        expect { subject }.to change { party.reload.phone_number }
        expect(response).to redirect_to("/party")
      end

      it "清空驗證中的手機號碼" do
        expect { subject }.to change { current_party.unconfirmed_phone.value }
      end
    end
  end
end
