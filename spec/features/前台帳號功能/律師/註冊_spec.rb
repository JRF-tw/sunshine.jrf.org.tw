require "rails_helper"

describe "律師註冊", type: :request do
  context "成功註冊" do
    let!(:lawyer) { FactoryGirl.create :lawyer }
    subject { post "/lawyer", lawyer: { name: lawyer.name, email: lawyer.email }, policy_agreement: "1" }

    it "發送密碼設定信" do
      expect { subject }.to change_sidekiq_jobs_size_of(CustomDeviseMailer, :send_confirm_mail)
    end

    it "跳轉到登入頁，並跳出註冊成功訊息" do
      expect(subject).to redirect_to("/lawyer/sign_in")
      expect(flash[:notice]).to eq("確認信件已送至您的 Email 信箱，請點擊信件內連結以啓動您的帳號。")
    end
  end

  context "失敗註冊" do
    context "失敗後的頁面" do
      subject! { post "/lawyer", lawyer: { name: "我是胖虎", email: "bigtiger@gmail.com" } }

      it "應保留原本輸入的內容" do
        expect(response.body).to match("我是胖虎")
        expect(response.body).to match("bigtiger@gmail.com")
      end
    end

    context "姓名 + email 存在於公會資料" do
      let!(:lawyer_with_confirmed) { FactoryGirl.create :lawyer, :with_password, :with_confirmed }
      subject { post "/lawyer", lawyer: { name: lawyer_with_confirmed.name, email: lawyer_with_confirmed.email }, policy_agreement: "1" }

      it "該律師已設定密碼" do
        expect(subject).to redirect_to("/lawyer/sign_in")
        expect(flash[:error]).to eq("已經註冊 請直接登入")
      end
    end

    context "姓名+email 不存在於公會資料" do
      let!(:lawyer) { FactoryGirl.create :lawyer }
      subject! { post "/lawyer", lawyer: { name: "胖虎", email: "KingOfKid@gmail.com" }, policy_agreement: "1" }

      context "轉跳頁面的錯誤訊息應顯示人工審核的連結" do
        it "顯示人工審核連結" do
          expect(flash[:error]).to eq("查無此律師資料 請改以人工管道註冊 <a href='/lawyer/appeal/new'>點此註冊</a>")
        end
      end

      context "email 正確、但姓名不符" do
        subject! { post "/lawyer", lawyer: { name: "胖虎", email: lawyer.email }, policy_agreement: "1" }

        it "顯示查無此律師" do
          expect(flash[:error]).to eq("查無此律師資料 請改以人工管道註冊 <a href='/lawyer/appeal/new'>點此註冊</a>")
          expect(response).to render_template("lawyer/registrations/new")
        end
      end

      context "姓名正確、但 email 不符" do
        subject! { post "/lawyer", lawyer: { name: lawyer.name, email: "bigtiger@gmail.com" }, policy_agreement: "1" }

        it "顯示查無此律師" do
          expect(flash[:error]).to eq("查無此律師資料 請改以人工管道註冊 <a href='/lawyer/appeal/new'>點此註冊</a>")
          expect(response).to render_template("lawyer/registrations/new")
        end
      end

      context "email + 姓名皆不符" do
        subject! { post "/lawyer", lawyer: { name: "胖虎", email: "bigtiger@gmail.com" }, policy_agreement: "1" }

        it "顯示查無此律師" do
          expect(flash[:error]).to eq("查無此律師資料 請改以人工管道註冊 <a href='/lawyer/appeal/new'>點此註冊</a>")
          expect(response).to render_template("lawyer/registrations/new")
        end
      end
    end

    context "沒有勾選「我已詳細閱讀服務條款和隱私權保護政策」" do
      let!(:lawyer) { FactoryGirl.create :lawyer }
      subject! { post "/lawyer", lawyer: { name: lawyer.name, email: lawyer.email } }

      it "顯示未勾選同意條款" do
        expect(flash[:error]).to eq("您尚未勾選同意條款")
        expect(response).to render_template("lawyer/registrations/new")
      end
    end

    context "輸入內容錯誤" do
      context "姓名空白" do
        subject! { post "/lawyer", lawyer: { name: "", email: "bigtiger@gmail.com" }, policy_agreement: "1" }

        it "顯示格式錯誤訊息" do
          expect(flash[:error]).to eq("姓名不可為空白字元")
          expect(response).to render_template("lawyer/registrations/new")
        end
      end

      context "email 格式不符" do
        subject! { post "/lawyer", lawyer: { name: "胖虎", email: "55566" }, policy_agreement: "1" }

        it "顯示查無此律師" do
          expect(flash[:error]).to eq("查無此律師資料 請改以人工管道註冊 <a href='/lawyer/appeal/new'>點此註冊</a>")
          expect(response).to render_template("lawyer/registrations/new")
        end
      end

      context "email 空白" do
        subject! { post "/lawyer", lawyer: { name: "胖虎", email: "" }, policy_agreement: "1" }

        it "顯示格式錯誤訊息" do
          expect(flash[:error]).to eq("email不可為空白字元")
          expect(response).to render_template("lawyer/registrations/new")
        end
      end
    end
  end
end
