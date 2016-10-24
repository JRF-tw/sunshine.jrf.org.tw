require 'rails_helper'

describe '觀察者登入', type: :request do
  let!(:court_observer) { create :court_observer }

  context '成功登入' do
    subject! { post '/observer/sign_in', court_observer: { email: court_observer.email, password: '123123123' } }

    it '導到個人評鑑紀錄頁' do
      expect(response).to redirect_to('/observer')
    end
  end

  context '失敗登入' do
    context 'email格式不符' do
      subject! { post '/observer/sign_in', court_observer: { email: 'email', password: '123123123' } }

      it '提示輸入的資訊無效' do
        expect(response.body).to match('輸入資訊是無效的。')
      end
    end

    context 'email未註冊' do
      subject! { post '/observer/sign_in', court_observer: { email: 'firewizard@gmail.com', password: '123123123' } }

      it '提示輸入的資訊無效' do
        expect(response.body).to match('輸入資訊是無效的。')
      end
    end

    context 'email空白' do
      subject! { post '/observer/sign_in', court_observer: { email: '', password: '123123123' } }

      it '提示信箱或密碼無效' do
        expect(response.body).to match('信箱或密碼是無效的。')
      end
    end

    context '密碼空白 + email 正確' do
      subject! { post '/observer/sign_in', court_observer: { email: court_observer.email, password: '' } }

      it '提示輸入的資訊無效' do
        expect(response.body).to match('輸入資訊是無效的。')
      end
    end

    context '密碼不正確 + email 正確' do
      subject! { post '/observer/sign_in', court_observer: { email: court_observer.email, password: 'nonononono' } }

      it '提示信箱或密碼無效' do
        expect(response.body).to match('信箱或密碼是無效的。')
      end
    end

    context '失敗後轉跳的頁面仍須保留原本輸入的 email' do
      subject! { post '/observer/sign_in', court_observer: { email: 'keepthis@gmail.com', password: '123123123' } }

      it '保留上次輸入email' do
        expect(response.body).to match('keepthis@gmail.com')
      end
    end

    context '尚未通過 email 驗證' do
      let!(:observer_without_confirm) { create :court_observer, :without_confirm }
      subject! { post '/observer/sign_in', court_observer: { email: observer_without_confirm.email, password: '123123123' } }

      it '提示需驗證後才能登入' do
        follow_redirect!
        expect(response.body).to match('您的帳號需要經過驗證後，才能繼續。')
      end
    end
  end
end
