require "rails_helper"

describe "當事人帳戶相關", type: :request do
  context "登入" do
    context "成功登入" do
      context "email未填仍可正常登入" do
        let!(:party) { FactoryGirl.create :party, email: "" }
        subject { post "/party/sign_in", party: { identify_number: party.identify_number, password: party.password } }

        it "導到個人評鑑紀錄頁" do
          expect(subject).to redirect_to("/party")
        end
      end

      context "email驗證中仍可正常登入" do
        let!(:party) { FactoryGirl.create :party, :with_unconfirmed_email }
        subject { post "/party/sign_in", party: { identify_number: party.identify_number, password: party.password } }

        it "導到個人評鑑紀錄頁" do
          expect(subject).to redirect_to("/party")
        end
      end

      context "email已驗證仍可正常登入" do
        let!(:party) { FactoryGirl.create :party, :already_confirmed }
        subject { post "/party/sign_in", party: { identify_number: party.identify_number, password: party.password } }

        it "導到個人評鑑紀錄頁" do
          expect(subject).to redirect_to("/party")
        end
      end
    end

    context "失敗登入" do
      context "手機未完成驗證" do
        let!(:party) { FactoryGirl.create :party, phone_number: nil }
        subject! { post "/party/sign_in", party: { identify_number: party.identify_number, password: party.password } }

        it "導到手機驗證流程" do
          follow_redirect!
          expect(response).to redirect_to("/party/phone/new")
        end
      end

      context "ID不存在" do
        let!(:party) { FactoryGirl.create :party }
        subject! { post "/party/sign_in", party: { identify_number: "F123333333", password: party.password } }

        it "提示輸入的資訊無效" do
          expect(response.body).to match("輸入資訊是無效的。")
        end
      end

      context "內容輸入錯誤" do
        let!(:party) { FactoryGirl.create :party }

        context "ID格式不符" do
          subject! { post "/party/sign_in", party: { identify_number: "FFFFF", password: party.password } }

          it "提示輸入的資訊無效" do
            expect(response.body).to match("輸入資訊是無效的。")
          end
        end

        context "ID空白" do
          subject! { post "/party/sign_in", party: { identify_number: "", password: party.password } }

          xit "TODO 修正提示訊息" do
            expect(response.body).to match("信箱或密碼是無效的")
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

          xit "TODO 修正提示訊息" do
            expect(response.body).to match("信箱或密碼是無效的")
          end
        end
      end
    end
  end

  context "註冊" do
    context "成功註冊" do
      let!(:params) { attributes_for(:party_for_create) }
      subject { post "/party", party: params, policy_agreement: "1" }

      it "轉跳到手機驗證頁" do
        expect(subject).to redirect_to("/party/phone/new")
      end

      it "帳號成功建立" do
        expect { subject }.to change { Party.count }
      end
    end

    context "失敗註冊" do
      context "失敗後的頁面" do
        subject! { post "/party", party: { name: "老夫子", identify_number: "f122121211", password: "00000000", password_confirmation: "123123123" } }

        it "應保留原本註冊內容" do
          expect(response.body).to match("老夫子")
          expect(response.body).to match("f122121211")
        end
      end

      context "ID 已註冊過" do
        let!(:party) { FactoryGirl.create :party, identify_number: "F122121211" }
        subject! { post "/party", party: { name: "老夫子", identify_number: "F122121211", password: "123123123", password_confirmation: "123123123" }, policy_agreement: "1" }

        it "轉跳頁面的錯誤訊息應顯示人工申訴的連結" do
          expect(response.body).to match("此身分證字號已經被使用 <a href='/party/appeal/new'>人工申訴連結</a>")
        end
      end

      context "ID 未註冊" do
        context "密碼兩次輸入不符" do
          subject! { post "/party", party: { name: "老夫子", identify_number: "F122121211", password: "11111111", password_confirmation: "00000000" }, policy_agreement: "1" }

          it "提示密碼與密碼確認須一致" do
            expect(response.body).to match("兩次輸入須一致")
          end
        end

        context "密碼過短" do
          subject! { post "/party", party: { name: "老夫子", identify_number: "F122121211", password: "111", password_confirmation: "111" }, policy_agreement: "1" }

          it "提示密碼過短" do
            expect(response.body).to match("過短（最短是 8 個字）")
          end
        end

        context "密碼空白" do
          subject! { post "/party", party: { name: "老夫子", identify_number: "F122121211", password: "", password_confirmation: "00000000" }, policy_agreement: "1" }

          it "提示密碼不可為空" do
            expect(response.body).to match("密碼 不可為空白字元")
          end
        end
      end

      context "沒有勾選「我已詳細閱讀服務條款和隱私權保護政策」" do
        subject! { post "/party", party: { name: "老夫子", identify_number: "F122121211", password: "00000000", password_confirmation: "00000000" } }

        it "提示尚未同意條款" do
          expect(response.body).to match("您尚未勾選同意條款")
        end
      end

      context "內容輸入錯誤" do
        context "姓名空白" do
          subject! { post "/party", party: { name: "", identify_number: "F122121211", password: "00000000", password_confirmation: "00000000" }, policy_agreement: "1" }

          it "提示姓名不可為空" do
            expect(response.body).to match("姓名 不可為空白字元")
          end
        end

        context "ID 不合法" do
          subject! { post "/party", party: { name: "老夫子", identify_number: "f122121211", password: "00000000", password_confirmation: "00000000" }, policy_agreement: "1" }

          it "提示身分證字號格式不符" do
            expect(response.body).to match("身分證字號格式不符")
          end
        end

        context "ID 格式不符" do
          context "非大寫英文字開頭" do
            subject! { post "/party", party: { name: "老夫子", identify_number: "f122121211", password: "00000000", password_confirmation: "00000000" }, policy_agreement: "1" }

            it "提示身分證字號格式不符" do
              expect(response.body).to match("身分證字號格式不符")
            end
          end

          context "非大寫英文字+9位數字" do
            subject! { post "/party", party: { name: "老夫子", identify_number: "f1211", password: "00000000", password_confirmation: "00000000" }, policy_agreement: "1" }

            it "提示身分證字號格式不符" do
              expect(response.body).to match("身分證字號格式不符")
            end
          end

          context "含有其他特殊字元" do
            subject! { post "/party", party: { name: "老夫子", identify_number: "f122!!++", password: "00000000", password_confirmation: "00000000" }, policy_agreement: "1" }

            it "提示身分證字號格式不符" do
              expect(response.body).to match("身分證字號格式不符")
            end
          end

          context "9位數字中含有英文字" do
            subject! { post "/party", party: { name: "老夫子", identify_number: "f122aoao11", password: "00000000", password_confirmation: "00000000" }, policy_agreement: "1" }

            it "提示身分證字號格式不符" do
              expect(response.body).to match("身分證字號格式不符")
            end
          end
        end

        context "ID 空白" do
          subject! { post "/party", party: { name: "老夫子", identify_number: "", password: "00000000", password_confirmation: "00000000" }, policy_agreement: "1" }

          it "提示身分證字號不可為空" do
            expect(response.body).to match("身分證字號 不可為空白字元")
          end
        end

        context "姓名 + ID空白" do
          subject! { post "/party", party: { name: "", identify_number: "", password: "00000000", password_confirmation: "00000000" }, policy_agreement: "1" }

          it "提示欄位不可為空" do
            expect(response.body).to match("身分證字號 不可為空白字元")
            expect(response.body).to match("姓名 不可為空白字元")
          end
        end
      end
    end
  end

  context "手機驗證流程" do
  end

  context "忘記密碼" do
  end

  context "密碼設定頁" do
  end

  context "更改 email" do
  end

  context "當事人更改手機號碼" do
  end

  context "人工申訴表單" do
  end
end
