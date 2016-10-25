require 'rails_helper'

RSpec.describe Lawyers::PasswordsController, type: :request do

  describe 'create' do
    context 'email unexist' do
      let!(:params) { { email: 'xxxx@gmail.com' } }
      subject! { post '/lawyer/password', lawyer: params }

      it { expect(response).to be_success }
      it { expect(response.body).to match(params[:email]) }
    end

    context 'email unconfirmed' do
      let!(:lawyer) { create :lawyer }
      let!(:params) { { email: lawyer.email } }
      subject { post '/lawyer/password', lawyer: params }

      it { expect { subject }.not_to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
      context 'retain input email' do
        before { subject }
        it { expect(response.body).to match(params[:email]) }
      end
    end

    context 'email confirmed' do
      let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
      let!(:params) { { email: lawyer.email } }
      subject { post '/lawyer/password', lawyer: params }

      it { expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
      it { expect(subject).to redirect_to('/lawyer/sign_in') }
    end
  end

  describe '#edit' do
    let!(:lawyer) { create :lawyer, :with_confirmed, :with_password }
    let(:token) { lawyer.send_reset_password_instructions }
    context 'success with sign in' do
      before { signin_lawyer(lawyer) }
      subject { get '/lawyer/password/edit', reset_password_token: token }

      it { expect(subject).to eq 200 }
    end

    context 'success without sign in' do
      subject { get '/lawyer/password/edit', reset_password_token: token }

      it { expect(subject).to eq 200 }
    end

    context 'fail' do
      context 'sign in other lawyer' do
        before { signin_lawyer }
        subject! { get '/lawyer/password/edit', reset_password_token: token }

        it { expect(subject).to eq 302 }
      end

      context 'sign in with invalid token' do
        before { signin_lawyer(lawyer) }
        subject! { get '/lawyer/password/edit', reset_password_token: 'invalid token' }

        it { expect(response).to redirect_to('/lawyer/profile') }
        it { expect(flash[:error]).to eq('無效的驗證連結') }
      end

      context 'invalid token' do
        subject! { get '/lawyer/password/edit', reset_password_token: 'invalid token' }

        it { expect(response).to redirect_to('/lawyer/sign_in') }
        it { expect(flash[:error]).to eq('無效的驗證連結') }
      end
    end
  end

  describe '#update' do
    let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
    let(:token) { lawyer.send_reset_password_instructions }
    context 'success with login' do
      before { signin_lawyer(lawyer) }
      subject! { put '/lawyer/password', lawyer: { password: '55667788', password_confirmation: '55667788', reset_password_token: token } }

      it { expect(response).to redirect_to('/lawyer') }
      it { expect(flash[:notice]).to eq('您的密碼已被修改，下次登入時請使用新密碼登入。') }
    end

    context 'success without login' do
      subject! { put '/lawyer/password', lawyer: { password: '55667788', password_confirmation: '55667788', reset_password_token: token } }

      it { expect(response).to redirect_to('/lawyer') }
      it { expect(flash[:notice]).to eq('您的密碼已被修改，下次登入時請使用新密碼登入。') }
    end

    context 'not alert to slack has password' do
      subject { put '/lawyer/password', lawyer: { password: '55667788', password_confirmation: '55667788', reset_password_token: token } }
      it { expect { subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end

    context 'alert to slack without password' do
      let!(:lawyer) { create :lawyer }
      subject { put '/lawyer/password', lawyer: { password: '55667788', password_confirmation: '55667788', reset_password_token: token } }
      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end
  end

  describe '#update for forst setting' do
    let!(:lawyer_data) { { name: '孔令則', phone: 33_381_841, email: 'kungls@hotmail.com' } }
    let!(:lawyer) { Import::CreateLawyerContext.new(lawyer_data).perform }
    let(:token) { lawyer.set_reset_password_token }

    context 'empty password should render form error' do
      subject! { put '/lawyer/password', lawyer: { password: '', password_confirmation: '', reset_password_token: token } }

      it { expect(response).to be_success }
    end

    context 'password unconfirmed should render form error' do
      subject! { put '/lawyer/password', lawyer: { password: '55667788', password_confirmation: 'aaaaaaaaa', reset_password_token: token } }

      it { expect(response).to be_success }
    end
  end

  describe '#send_reset_password_mail' do
    before { signin_lawyer }
    subject! { post '/lawyer/password/send_reset_password_mail' }

    it { expect(response).to redirect_to('/lawyer/profile') }
  end

end
