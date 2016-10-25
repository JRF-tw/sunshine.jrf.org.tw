require 'rails_helper'

RSpec.describe CourtObservers::RegistrationsController, type: :request do

  describe 'create' do
    context 'alert to slack' do
      subject { post '/observer', court_observer: attributes_for(:court_observer_for_create), policy_agreement: '1' }
      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end
  end

  describe '#update' do
    before { signin_court_observer }
    let!(:court_observer) { current_court_observer }
    let!(:old_email) { court_observer.email }

    context 'success' do
      subject { put '/observer', court_observer: { email: 'h2312@gmail.com', current_password: '123123123' } }
      it { expect(subject).to redirect_to('/observer/profile') }
      it { expect { subject }.to change { court_observer.reload.unconfirmed_email } }
    end

    context 'sign in after updated' do
      before { put '/observer', court_observer: { email: 'h2312@gmail.com', current_password: '123123123' } }
      before { signout_court_observer }
      subject { post '/observer/sign_in', court_observer: { email: court_observer.email, password: '123123123' } }

      it { expect { subject }.to change { court_observer.reload.current_sign_in_at } }
    end

    context 'sign in new email after updated and confirm' do
      before { put '/observer', court_observer: { email: 'h2312@gmail.com', current_password: '123123123' } }
      before { signout_court_observer }
      before { get '/observer/confirmation', confirmation_token: court_observer.reload.confirmation_token }

      subject { post '/observer/sign_in', court_observer: { email: 'h2312@gmail.com', password: '123123123' } }
      it { expect { subject }.to change { court_observer.reload.current_sign_in_at } }
    end

    context 'sign in old email after updated and confirm' do
      before { put '/observer', court_observer: { email: 'h2312@gmail.com', current_password: '123123123' } }
      before { signout_court_observer }
      before { get '/observer/confirmation', confirmation_token: court_observer.reload.confirmation_token }

      subject { post '/observer/sign_in', court_observer: { email: old_email, password: '123123123' } }
      it { expect { subject }.to_not change { court_observer.reload.current_sign_in_at } }
    end

  end

end
