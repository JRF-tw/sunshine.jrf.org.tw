require 'rails_helper'

RSpec.describe CourtObservers::EmailsController, type: :request do
  let(:observer) { create :court_observer, :with_unconfirmed_email, :with_confirmation_token }
  before { signin_court_observer(observer) }

  describe '#edit' do
    subject! { get '/observer/email/edit' }
    it { expect(response).to be_success }
  end

  describe '#update' do
    before { signin_court_observer }
    context 'success' do
      subject { put '/observer/email', court_observer: { email: '5566@gmail.com', current_password: '123123123' } }
      it { expect { subject }.to change_sidekiq_jobs_size_of(Sidekiq::Extensions::DelayedMailer) }
      it { expect(subject).to redirect_to('/observer/profile') }
    end

    context 'wrong password' do
      subject! { put '/observer/email', court_observer: { email: '5566@gmail.com', current_password: '' } }

      it { expect(current_court_observer.email).not_to eq('5566@gmail.com') }
      it { expect(response.body).to match('5566@gmail.com') }
    end
  end

  describe '#resend_confirmation_mail' do
    subject { post '/observer/email/resend_confirmation_mail' }

    it { expect { subject }.to change_sidekiq_jobs_size_of(CustomDeviseMailer, :resend_confirmation_instructions) }

    context 'redirect success' do
      before { subject }
      it { expect(flash[:notice]).to eq('您將在幾分鐘後收到一封電子郵件，內有驗證帳號的步驟說明。') }
      it { expect(response).to redirect_to('/observer/profile') }
    end
  end
end
