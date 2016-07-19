require "rails_helper"

describe "當事人手機驗證流程", type: :request do
  context "手機驗證流程" do
    context "手機號碼輸入頁" do
      context "成功送出" do
        before { signin_party }
        subject { post "/party/phone", party: { phone_number: "0911111111" } }

        it "轉跳至認證輸入頁" do
          expect(subject).to redirect_to("/party/phone/verify")
        end

        it "發送簡訊" do
          expect { subject }.to change_sidekiq_jobs_size_of(SmsService, :send_to)
        end
      end

      context "失敗送出" do
        context "該手機號碼已被別人驗證" do
          before { signin_party }
          let!(:party) { FactoryGirl.create :party, phone_number: "0911111111" }
          subject! { post "/party/phone", party: { phone_number: "0911111111" } }

          it "提示號碼已經被使用" do
            expect(response.body).to match("該手機號碼已註冊")
          end
        end

        context "該手機號碼正在被別人驗證中" do
          before { party_with_unconfirm_phone_number("0911111111") }
          before { signin_party }
          subject! { post "/party/phone", party: { phone_number: "0911111111" } }

          it "提示號碼已經被使用" do
            expect(response.body).to match("該手機號碼正等待驗證中")
          end
        end

        context "連續發送 n 次後，使目前已超過簡訊發送限制" do
          let!(:party) { party_with_sms_send_count(2) }
          before { signin_party(party) }
          subject! { post "/party/phone", party: { phone_number: "0911111113" } }

          it "提示五分鐘只能寄送兩次" do
            expect(response.body).to match("五分鐘內只能寄送兩次簡訊")
          end
        end

        context "號碼格式不符" do
          before { signin_party }

          context "空白" do
            subject! { post "/party/phone", party: { phone_number: "" } }

            it "提示手機號碼不可為空" do
              expect(response.body).to match("手機號碼為必填欄位")
            end
          end

          context "過長" do
            subject! { post "/party/phone", party: { phone_number: "091111111111" } }

            it "提示手機號碼格式不符" do
              expect(response.body).to match("手機號碼格式錯誤")
            end
          end

          context "過短" do
            subject! { post "/party/phone", party: { phone_number: "0911" } }

            it "提示手機號碼格式不符" do
              expect(response.body).to match("手機號碼格式錯誤")
            end
          end

          context "非09開頭" do
            subject! { post "/party/phone", party: { phone_number: "0811111111" } }

            it "提示手機號碼格式不符" do
              expect(response.body).to match("手機號碼格式錯誤")
            end
          end

          context "非全數字" do
            subject! { post "/party/phone", party: { phone_number: "091111a111" } }

            it "提示手機號碼格式不符" do
              expect(response.body).to match("手機號碼格式錯誤")
            end
          end
        end
      end
    end

    context "認證碼輸入頁" do
      before { signin_party }

      context "成功驗證" do
        before { party_generate_phone_varify_code(current_party) }
        subject! { put "/party/phone/verifing", party: { phone_varify_code: current_party.phone_varify_code.value } }

        it "轉跳到評鑑記錄頁，並跳出「註冊成功」訊息" do
          expect(response).to redirect_to("/party")
          expect(flash[:success]).to eq("已驗證成功")
        end
      end

      context "失敗驗證" do
        context "驗證碼空白" do
          before { party_generate_phone_varify_code(current_party) }
          subject! { put "/party/phone/verifing", party: { phone_varify_code: "" } }

          it "提示驗證碼輸入錯誤" do
            expect(response.body).to match("驗證碼輸入錯誤")
          end
        end

        context "驗證碼錯誤" do
          before { party_generate_phone_varify_code(current_party, "3333") }
          subject! { put "/party/phone/verifing", party: { phone_varify_code: "2222" } }

          it "提示驗證碼輸入錯誤" do
            expect(response.body).to match("驗證碼輸入錯誤")
          end
        end

        context "驗證碼輸入錯誤太多次" do
          before { party_generate_phone_varify_code(current_party) }
          before { party_verifing_error_times(3) }
          subject! { put "/party/phone/verifing", party: { phone_varify_code: "" } }

          it "重新導向到修改手機號碼頁面" do
            expect(response).to redirect_to("/party/phone/edit")
          end
        end

        context "已超過可驗證的期限" do
          before { current_party.phone_varify_code.value = nil }
          subject! { put "/party/phone/verifing", party: { phone_varify_code: "1111" } }

          it "提示重設手機號碼" do
            expect(flash[:error]).to match("請先設定手機號碼")
          end
        end
      end
    end
  end
end
