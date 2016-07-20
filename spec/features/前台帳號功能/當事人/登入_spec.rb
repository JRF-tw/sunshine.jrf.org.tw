require "rails_helper"

describe "當事人登入", type: :request do
  context "成功登入" do
    context "email未填仍可正常登入" do
      let!(:party) { create :party, email: nil }
      subject { post "/party/sign_in", party: { identify_number: party.identify_number, password: party.password } }

      it "導到個人評鑑紀錄頁" do
        expect(subject).to redirect_to("/party")
      end
    end

    context "email驗證中仍可正常登入" do
      let!(:party) { create :party, :with_unconfirmed_email }
      subject { post "/party/sign_in", party: { identify_number: party.identify_number, password: party.password } }

      it "導到個人評鑑紀錄頁" do
        expect(subject).to redirect_to("/party")
      end
    end

    context "email已驗證仍可正常登入" do
      let!(:party) { create :party, :already_confirmed }
      subject { post "/party/sign_in", party: { identify_number: party.identify_number, password: party.password } }

      it "導到個人評鑑紀錄頁" do
        expect(subject).to redirect_to("/party")
      end
    end
  end

  context "失敗登入" do
    context "手機未完成驗證" do
      let!(:party) { create :party, phone_number: nil }
      subject! { post "/party/sign_in", party: { identify_number: party.identify_number, password: party.password } }

      it "導到手機驗證流程" do
        follow_redirect!
        expect(response).to redirect_to("/party/phone/new")
      end
    end

    context "ID不存在" do
      let!(:party) { create :party }
      subject! { post "/party/sign_in", party: { identify_number: "F123333333", password: party.password } }

      it "提示輸入的資訊無效" do
        expect(response.body).to match("輸入資訊是無效的。")
      end
    end

    context "內容輸入錯誤" do
      let!(:party) { create :party }

      context "ID格式不符" do
        subject! { post "/party/sign_in", party: { identify_number: "FFFFF", password: party.password } }

        it "提示輸入的資訊無效" do
          expect(response.body).to match("輸入資訊是無效的。")
        end
      end

      context "ID空白" do
        subject! { post "/party/sign_in", party: { identify_number: "", password: party.password } }

        it "提示身分證或密碼無效" do
          expect(response.body).to match("身分證或密碼是無效的。")
        end
      end

      context "ID正確+密碼空白" do
        subject! { post "/party/sign_in", party: { identify_number: party.identify_number, password: "" } }

        it "提示輸入的資訊無效" do
          expect(response.body).to match("輸入資訊是無效的。")
        end
      end

      context "ID正確+密碼錯誤" do
        subject! { post "/party/sign_in", party: { identify_number: party.identify_number, password: "WRONG-password" } }

        it "提示身分證或密碼無效" do
          expect(response.body).to match("身分證或密碼是無效的。")
        end
      end
    end
  end
end
