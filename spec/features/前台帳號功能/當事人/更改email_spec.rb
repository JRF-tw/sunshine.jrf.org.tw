require "rails_helper"

describe "當事人更改email", type: :request do
  let!(:party) { create :party }

  context "成功送出" do
    before { signin_party(party) }

    context "新的 email 為別人正在驗證中的 email ，也可以成功送出" do
      let!(:party_with_unconfirmed_email) { create :party, unconfirmed_email: "556677@gmail.com" }
      subject { put "/party/email", party: { email: party_with_unconfirmed_email.unconfirmed_email, current_password: "12321313213" } }

      it "成功送出" do
        expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq)
      end
    end

    context "發送信件" do
      subject { put "/party/email", party: { email: "5566@gmail.com", current_password: "12321313213" } }

      it "成功送出" do
        expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq)
      end
    end

    context "內容連結點擊後成功換置新的 email" do
      before { put "/party/email", party: { email: "windwizard@gmail.com", current_password: "12321313213" } }
      subject! { get "/party/confirmation", confirmation_token: party.reload.confirmation_token }

      it "成功更新email" do
        expect(party.reload.email).to eq("windwizard@gmail.com")
      end
    end
  end

  context "失敗送出" do
    context "內容錯誤" do
      before { signin_party(party) }

      context "新 email 空白" do
        subject! { put "/party/email", party: { email: "", current_password: "12321313213" } }

        it "顯示格式錯誤" do
          expect(response.body).to match("email 的格式是無效的")
        end
      end

      context "新 email 格式不符" do
        subject! { put "/party/email", party: { email: "4554", current_password: "12321313213" } }

        it "email 格式錯誤" do
          expect(flash[:error]).to eq("email 的格式是無效的")
        end
      end

      context "密碼驗證錯誤" do
        subject! { put "/party/email", party: { email: "ggyy@gmail.com", current_password: "33333333" } }

        it "顯示密碼無效" do
          expect(response.body).to match("是無效的")
        end
      end

      context "密碼驗證空白" do
        subject! { put "/party/email", party: { email: "ggyy@gmail.com", current_password: "" } }

        it "顯示不可為空" do
          expect(response.body).to match("不能是空白字元")
        end
      end
    end

    context "email 已經被使用" do
      context "新 email 是別人的email" do
        let!(:party2) { create :party, email: "ggyy@gmail.com" }
        before { signin_party(party) }
        subject! { put "/party/email", party: { email: party2.email, current_password: "12321313213" } }

        it "顯示已經被使用" do
          expect(response.body).to match("email 已經被使用")
        end
      end

      context "新 email 跟原本的一樣" do
        before { signin_party(party) }
        subject! { put "/party/email", party: { email: party.email, current_password: "12321313213" } }

        it "顯示不可與原本相同" do
          expect(response.body).to match("email 不可與原本相同")
        end
      end
    end

    context "其他情境" do
      context "當事人A與B 有相同的待驗證email, A點完驗證連結之後 B才點驗證連結" do
        let!(:party_A) { party_with_unconfirm_email("ggyy@gmail.com") }
        let!(:party_B) { party_with_unconfirm_email("ggyy@gmail.com") }
        before { get "/party/confirmation", confirmation_token: party_A.reload.confirmation_token }
        subject { get "/party/confirmation", confirmation_token: party_B.confirmation_token }

        it "當事人A 的email 置換成功" do
          expect(party_A.reload.email).to eq("ggyy@gmail.com")
        end

        it "當事人B 的email 置換失敗" do
          expect { subject }.not_to change { party_B.email }
        end
      end
    end
  end
end
