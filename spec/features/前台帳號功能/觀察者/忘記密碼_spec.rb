require 'rails_helper'

describe '觀察者忘記密碼', type: :request do
  context '成功送出' do
    let!(:court_observer) { create :court_observer }
    subject { post '/observer/password', court_observer: { email: court_observer.email } }

    it '發送重設密碼信' do
      expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq)
    end

    it '轉跳至登入頁面' do
      expect(subject).to redirect_to('/observer/sign_in')
    end
  end

  context '失敗送出' do
    let!(:court_observer) { create :court_observer }

    context 'email 空白' do
      subject! { post '/observer/password', court_observer: { email: '' } }

      it '提示不可為空' do
        expect(response.body).to match('不能是空白字元')
      end
    end

    context 'email 格式不符' do
      subject! { post '/observer/password', court_observer: { email: 'eeee' } }

      it '提示無此email' do
        expect(response.body).to match('找不到')
      end
    end

    context 'email 不存在' do
      subject! { post '/observer/password', court_observer: { email: 'firewizard@gmail.com' } }

      it '提示無此email' do
        expect(response.body).to match('找不到')
      end
    end

    context '該帳號存在，但是尚未完成註冊' do
      let(:court_observer_without_validate) { create :court_observer_without_validate }
      subject! { post '/observer/password', court_observer: { email: court_observer_without_validate.email } }

      it '提示該帳號尚未認證' do
        expect(flash[:error]).to eq('此帳號尚未驗證')
      end
    end
  end
end
