require 'rails_helper'

RSpec.describe CourtObservers::ProfilesController, type: :request do
  before { signin_court_observer }

  describe '#show' do
    subject! { get '/observer/profile' }
    it { expect(response).to be_success }
  end

  describe '#edit' do
    subject! { get '/observer/profile/edit' }
    it { expect(response).to be_success }
  end

  describe '#update' do
    context 'success' do
      subject! { put '/observer/profile', court_observer: { phone_number: '0922222222' } }
      it { expect(response).to redirect_to('/observer/profile') }
    end

    context 'fails' do
      context 'empty name' do
        subject! { put '/observer/profile', court_observer: { name: '', phone_number: '0933803939' } }
        it { expect(response.body).to match('0933803939') }
        it { expect(response).to render_template('edit') }
      end

      context 'invalid phone_number' do
        subject! { put '/observer/profile', court_observer: { name: '柯南', phone_number: '111122' } }
        it { expect(response.body).to match('柯南') }
        it { expect(response.body).to match('111122') }
        it { expect(response).to render_template('edit') }
      end
    end
  end
end
