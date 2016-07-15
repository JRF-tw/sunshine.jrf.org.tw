require "rails_helper"

describe "當事人帳戶相關", type: :request do
  context "登入" do
    context "成功登入" do
      context "email未填仍可正常登入" do
        let!(:party) { FactoryGirl.create :party, email: nil }
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

          it "TODO 修正提示訊息" do
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

          it "TODO 修正提示訊息" do
            expect(response.body).to match("身分證或密碼是無效的。")
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
          before { init_party_with_unconfirm_phone_number("0911111111") }
          before { signin_party }
          subject! { post "/party/phone", party: { phone_number: "0911111111" } }

          it "提示號碼已經被使用" do
            expect(response.body).to match("該手機號碼正等待驗證中")
          end
        end

        context "連續發送 n 次後，使目前已超過簡訊發送限制" do
          before { signin_party }
          before { post "/party/phone", party: { phone_number: "0911111111" } }
          before { post "/party/phone", party: { phone_number: "0911111112" } }
          before { post "/party/phone", party: { phone_number: "0911111113" } }

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
        before { current_party.phone_varify_code = "1111" }
        subject! { put "/party/phone/verifing", party: { phone_varify_code: "1111" } }

        it "轉跳到評鑑記錄頁，並跳出「註冊成功」訊息" do
          expect(response).to redirect_to("/party")
          expect(flash[:success]).to eq("已驗證成功")
        end
      end

      context "失敗驗證" do
        context "驗證碼空白" do
          before { current_party.phone_varify_code = "1111" }
          subject! { put "/party/phone/verifing", party: { phone_varify_code: "" } }

          it "提示驗證碼輸入錯誤" do
            expect(response.body).to match("驗證碼輸入錯誤")
          end
        end

        context "驗證碼錯誤" do
          before { current_party.phone_varify_code = "1111" }
          subject! { put "/party/phone/verifing", party: { phone_varify_code: "2222" } }

          it "提示驗證碼輸入錯誤" do
            expect(response.body).to match("驗證碼輸入錯誤")
          end
        end

        context "驗證碼輸入錯誤太多次" do
          before { current_party.phone_varify_code = "1111" }
          before { put "/party/phone/verifing", party: { phone_varify_code: "" } }
          before { put "/party/phone/verifing", party: { phone_varify_code: "" } }
          before { put "/party/phone/verifing", party: { phone_varify_code: "" } }
          before { put "/party/phone/verifing", party: { phone_varify_code: "" } }

          it "重新導向到修改手機號碼頁面" do
            expect(response).to redirect_to("/party/phone/edit")
          end
        end

        context "已超過可驗證的期限" do
          before { current_party.phone_varify_code = "1111" }
          before { current_party.phone_varify_code = nil }
          subject! { put "/party/phone/verifing", party: { phone_varify_code: "1111" } }

          it "提示重設手機號碼" do
            expect(flash[:error]).to match("請先設定手機號碼")
          end
        end
      end
    end
  end

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
        let!(:params) { { identify_number: party.identify_number, phone_number: party.phone_number } }
        before { post "/party/password", party: params }
        before { post "/party/password", party: params }
        before { post "/party/password", party: params }

        it "連續發送 2 次後，達限制上限" do
          expect(response.body).to match("五分鐘內只能寄送兩次簡訊")
        end
      end

      context "手機號碼未驗證" do
        let!(:party_with_unconfirm_phone_number) { init_party_with_unconfirm_phone_number("0911828181") }
        before { post "/party/password", party: { identify_number: party_with_unconfirm_phone_number.identify_number, phone_number: "0911828181" } }

        it "顯示錯誤訊息，並提示可進行人工申訴" do
          expect(response.body).to match("手機號碼尚未驗證 <a href='/party/appeal/new'>人工申訴</a>")
        end
      end

      context "驗證錯誤" do
        context "手機號碼存在，ID 不存在" do
          before { post "/party/password", party: { identify_number: "F123456789", phone_number: party.phone_number } }

          it "顯示無此當事人資訊" do
            expect(response.body).to match("沒有此當事人資訊")
          end
        end

        context "手機號碼不存在，ID 存在" do
          before { post "/party/password", party: { identify_number: party.identify_number, phone_number: "0911111111" } }

          it "顯示手機號碼錯誤" do
            expect(response.body).to match("手機號碼輸入錯誤")
          end
        end

        context "手機號碼不存在，ID 不存在" do
          before { post "/party/password", party: { identify_number: "F123456789", phone_number: "0911111111" } }

          it "顯示無此當事人資訊" do
            expect(response.body).to match("沒有此當事人資訊")
          end
        end
      end

      context "輸入內容錯誤" do
        context "ID空白" do
          before { post "/party/password", party: { identify_number: "", phone_number: party.phone_number } }

          it "顯示無此當事人資訊" do
            expect(response.body).to match("沒有此當事人資訊")
          end
        end

        context "手機號碼空白" do
          before { post "/party/password", party: { identify_number: party.identify_number, phone_number: "" } }

          it "顯示手機號碼錯誤" do
            expect(response.body).to match("手機號碼輸入錯誤")
          end
        end

        context "ID + 手機號碼皆空白" do
          before { post "/party/password", party: { identify_number: "", phone_number: "" } }

          it "顯示無此當事人資訊" do
            expect(response.body).to match("沒有此當事人資訊")
          end
        end
      end
    end
  end

  context "密碼設定頁" do
    context "成功載入頁面" do
      let!(:party) { FactoryGirl.create :party }
      let(:token) { party.send_reset_password_instructions }

      context "有登入" do
        before { signin_party(party) }
        subject! { get "/party/password/edit", reset_password_token: token }

        it "應顯示該當事人的姓名和ID" do
          expect(response.body).to match(party.name)
          expect(response.body).to match(party.identify_number)
        end
      end

      context "沒登入" do
        subject! { get "/party/password/edit", reset_password_token: token }

        it "應顯示該當事人的姓名和ID" do
          expect(response.body).to match(party.name)
          expect(response.body).to match(party.identify_number)
        end
      end
    end

    context "失敗載入頁面" do
      let!(:party) { FactoryGirl.create :party }
      let(:token) { party.send_reset_password_instructions }

      context "條件" do
        context "token 不正確" do
          subject! { get "/party/password/edit", reset_password_token: "wrong token" }

          it "顯示 token 錯誤" do
            expect(flash[:error]).to eq("無效的驗證連結")
          end
        end

        context "token 正確 但登入者非本人" do
          before { signin_party }
          subject! { get "/party/password/edit", reset_password_token: token }

          it "顯示使用者錯誤" do
            expect(flash[:error]).to eq("你僅能修改本人的帳號")
          end
        end
      end

      context "有登入時，轉跳至個人資料編輯頁" do
        before { signin_party }
        subject! { get "/party/password/edit", reset_password_token: token }

        it "轉跳至個人資料編輯頁" do
          expect(response).to redirect_to("/party/profile")
        end
      end

      context "沒登入時，轉跳至登入頁" do
        subject! { get "/party/password/edit", reset_password_token: "wrong token" }

        it "轉跳至當事人登入頁" do
          expect(response).to redirect_to("/party/sign_in")
        end
      end
    end

    context "成功設定" do
      let!(:party) { FactoryGirl.create :party }
      let(:token) { party.send_reset_password_instructions }
      subject { put "/party/password", party: { password: "11111111", password_confirmation: "11111111", reset_password_token: token } }

      it "沒登入時自動登入" do
        expect { subject }.to change { party.reload.current_sign_in_at }
      end

      it "有登入時，成功更改密碼" do
        expect { subject }.to change { party.reload.encrypted_password }
      end

      context "若手機尚未驗證，則會自動轉跳到手機驗證頁" do
        let!(:party_without_phone_unmber) { FactoryGirl.create :party, phone_number: nil }
        let(:token) { party_without_phone_unmber.send_reset_password_instructions }
        subject! { put "/party/password", party: { password: "11111111", password_confirmation: "11111111", reset_password_token: token } }

        it "轉跳到手機驗證頁" do
          follow_redirect!
          expect(response).to redirect_to("/party/phone/new")
        end
      end

      context "若手機已驗證，則會轉跳到評鑑記錄頁" do
        let!(:party) { FactoryGirl.create :party }
        let(:token) { party.send_reset_password_instructions }
        subject! { put "/party/password", party: { password: "11111111", password_confirmation: "11111111", reset_password_token: token } }

        it "轉跳評鑑紀錄頁" do
          expect(response).to redirect_to("/party")
        end
      end
    end

    context "失敗設定" do
      let!(:party) { FactoryGirl.create :party }
      let(:token) { party.send_reset_password_instructions }

      context "密碼空白" do
        subject! { put "/party/password", party: { password: "", password_confirmation: "", reset_password_token: token } }

        it "顯示不可為空" do
          expect(response.body).to match("不能是空白字元")
        end
      end

      context "密碼長度過短" do
        subject! { put "/party/password", party: { password: "11", password_confirmation: "11", reset_password_token: token } }

        it "顯示密碼過短" do
          expect(response.body).to match("過短（最短是 8 個字）")
        end
      end

      context "密碼兩次不一致" do
        subject! { put "/party/password", party: { password: "11111111", password_confirmation: "33333333", reset_password_token: token } }

        it "顯示不可為空" do
          expect(response.body).to match("兩次輸入須一致")
        end
      end
    end
  end

  context "更改 email" do
    let!(:party) { FactoryGirl.create :party }

    context "成功送出" do
      before { signin_party(party) }

      context "新的 email 為別人正在驗證中的 email ，也可以成功送出" do
        let!(:party_with_unconfirmed_email) { FactoryGirl.create :party, unconfirmed_email: "556677@gmail.com" }
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

          it "顯示不可為空" do
            expect(response.body).to match("email 不可為空")
          end
        end

        context "新 email 格式不符" do
          subject! { put "/party/email", party: { email: "4554", current_password: "12321313213" } }

          it "email 格式錯誤" do
            expect(flash[:error]).to eq("無效的 email")
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
          let!(:party2) { FactoryGirl.create :party, email: "ggyy@gmail.com" }
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
          let!(:party_A) { init_party_with_unconfirm_email("ggyy@gmail.com") }
          let!(:party_B) { init_party_with_unconfirm_email("ggyy@gmail.com") }
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

  context "當事人更改手機號碼" do
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
          before { init_party_with_unconfirm_phone_number("0911111111") }
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
            expect(response.body).to match("該手機號碼已註冊")
          end
        end

        context "目前已超過簡訊發送限制" do
          context "連續成功送出更改手機號碼的認證簡訊（每次都不同號碼），使其達到上限" do
            before { signin_party }
            before { put "/party/phone", party: { phone_number: "0911111111" } }
            before { put "/party/phone", party: { phone_number: "0911111112" } }
            before { put "/party/phone", party: { phone_number: "0911111113" } }

            it "提示五分鐘只能寄送兩次" do
              expect(response.body).to match("五分鐘內只能寄送兩次簡訊")
            end
          end

          context "連續發送忘記密碼簡訊，使其達到上限" do
            let!(:params) { { identify_number: party.identify_number, phone_number: party.phone_number } }
            before { post "/party/password", party: params }
            before { post "/party/password", party: params }
            before { post "/party/password", party: params }

            it "連續發送 2 次後，達限制上限" do
              expect(response.body).to match("五分鐘內只能寄送兩次簡訊")
            end
          end

          context "連續發送忘記密碼和更改手機號碼簡訊，使其達到上限" do
            before { post "/party/password", party: { identify_number: party.identify_number, phone_number: party.phone_number } }
            before { signin_party(party) }
            before { put "/party/phone", party: { phone_number: "0911111111" } }
            before { put "/party/phone", party: { phone_number: "0911111112" } }

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

  context "人工申訴表單" do
  end
end
