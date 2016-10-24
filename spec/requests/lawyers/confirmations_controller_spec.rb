require 'rails_helper'

RSpec.describe Lawyers::ConfirmationsController, type: :request do
  let!(:lawyer) { create :lawyer }

  describe '#show' do
    context 'validate token' do
      context 'need set password' do
        subject! { get '/lawyer/confirmation', confirmation_token: lawyer.confirmation_token }

        it { expect(response).to be_redirect }
      end

      context 'only confirm' do
        let!(:lawyer) { create :lawyer, :with_password }
        subject! { get '/lawyer/confirmation', confirmation_token: lawyer.confirmation_token }

        it { expect(response).to redirect_to('/lawyer/sign_in') }
      end
    end

    context 'invalidate token' do
      subject! { get '/lawyer/confirmation', confirmation_token: 'wwwwwww' }

      it { expect(response).to redirect_to('/lawyer/sign_in') }
    end
  end

end
