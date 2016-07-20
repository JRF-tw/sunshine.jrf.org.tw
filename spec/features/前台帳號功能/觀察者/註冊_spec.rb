require "rails_helper"

describe "觀察者註冊", type: :request do
  context "成功註冊" do
    subject { post "/observer", court_observer: { name: "阿怪", email: "h2312@gmail.com", password: "123123123", password_confirmation: "123123123" }, policy_agreement: "1" }

    it "發送驗證信" do
      expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq)
    end

    it "轉跳到登入頁，並跳出註冊成功訊息" do
      expect(subject).to redirect_to("/observer/sign_in")
      expect(flash[:notice]).to eq("確認信件已送至您的 Email 信箱，請點擊信件內連結以啓動您的帳號。")
    end
  end

  context "失敗註冊" do
    context "失敗後的頁面" do
      subject! { post "/observer", court_observer: { name: "阿怪", email: "h2312@gmail.com", password: "123123123", password_confirmation: "22222222" }, policy_agreement: "1" }

      it "應保留原本輸入的內容" do
        expect(response.body).to match("阿怪")
        expect(response.body).to match("h2312@gmail.com")
      end
    end

    context "email已存在，且已驗證" do
      let!(:court_observer) { create :court_observer }
      subject { post "/observer", court_observer: { name: "阿怪", email: court_observer.email, password: "123123123", password_confirmation: "123123123" }, policy_agreement: "1" }

      it "轉跳至登入頁" do
        expect(subject).to redirect_to("/observer/sign_in")
        expect(flash[:error]).to eq("您已經註冊請直接登入")
      end
    end

    context "email 已存在，但未驗證" do
      let!(:court_observer_without_validate) { create :court_observer_without_validate }
      subject { post "/observer", court_observer: { name: "阿怪", email: court_observer_without_validate.email, password: "123123123", password_confirmation: "123123123" }, policy_agreement: "1" }

      it "發送驗證信" do
        expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq)
      end

      it "轉跳至登入頁" do
        expect(subject).to redirect_to("/observer/sign_in")
        expect(flash[:error]).to eq("此email已經註冊 驗證信已發送到您的信箱 請點擊連結驗證後登入")
      end
    end

    context "沒有勾選「我已詳細閱讀服務條款和隱私權保護政策」" do
      subject! { post "/observer", court_observer: { name: "阿怪", email: "h2312@gmail.com", password: "123123123", password_confirmation: "123123123" }, policy_agreement: "0" }

      it "提示尚未同意條款" do
        expect(flash[:error]).to eq("您尚未勾選同意條款")
      end
    end

    context "輸入內容錯誤" do
      context "姓名空白" do
        subject! { post "/observer", court_observer: { name: "", email: "h2312@gmail.com", password: "123123123", password_confirmation: "123123123" }, policy_agreement: "1" }

        it "提示姓名不可空白" do
          expect(flash[:error]).to eq("姓名 不可為空白字元")
        end
      end

      context "email 格式不符" do
        subject! { post "/observer", court_observer: { name: "阿怪", email: "h2312", password: "123123123", password_confirmation: "123123123" }, policy_agreement: "1" }

        it "提示email 無效" do
          expect(response.body).to match("是無效的")
        end
      end

      context "email空白" do
        subject! { post "/observer", court_observer: { name: "阿怪", email: "", password: "123123123", password_confirmation: "123123123" }, policy_agreement: "1" }

        it "提示email不可空白" do
          expect(flash[:error]).to eq("email 不可為空白字元")
        end
      end

      context "密碼空白" do
        subject! { post "/observer", court_observer: { name: "阿怪", email: "h2312@gmail.com", password: "", password_confirmation: "123123123" }, policy_agreement: "1" }

        it "提示密碼不可空白" do
          expect(flash[:error]).to eq("密碼 不可為空白字元")
        end
      end

      context "密碼和確認密碼兩次內容不一致" do
        subject! { post "/observer", court_observer: { name: "阿怪", email: "h2312@gmail.com", password: "11111111", password_confirmation: "22222222" }, policy_agreement: "1" }

        it "提示密碼與密碼確認須一致" do
          expect(response.body).to match("兩次輸入須一致")
        end
      end

      context "密碼過短" do
        subject! { post "/observer", court_observer: { name: "阿怪", email: "h2312@gmail.com", password: "11", password_confirmation: "11" }, policy_agreement: "1" }

        it "提示密碼過短" do
          expect(response.body).to match("過短（最短是 8 個字）")
        end
      end

      context "四格任一項空白" do
        subject! { post "/observer", court_observer: { name: "阿怪", email: "h2312@gmail.com", password: "11", password_confirmation: "" }, policy_agreement: "1" }

        it "提示該欄位不可為空" do
          expect(flash[:error]).to eq("密碼確認 不可為空白字元")
        end
      end
    end
  end
end
