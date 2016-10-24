require 'rails_helper'

RSpec.describe Lawyers::RegistrationsController, type: :request do

  describe 'create' do
    context 'success' do
      let!(:lawyer) { create :lawyer }
      before { post '/lawyer', lawyer: { name: lawyer.name, email: lawyer.email }, policy_agreement: '1' }
      it { expect(response).to redirect_to('/lawyer/sign_in') }
    end

    context 'lawyer not found' do
      let!(:lawyer) { create :lawyer }
      before { post '/lawyer', lawyer: { name: '先生', email: '1234@example.com' }, policy_agreement: '1' }

      it { expect(subject).to render_template('lawyers/registrations/new') }
    end

    context 'empty params' do
      let!(:lawyer) { create :lawyer }
      before { post '/lawyer', lawyer: { name: '', email: '' }, policy_agreement: '1' }

      it { expect(subject).to render_template('lawyers/registrations/new') }
    end

    context 'lawyer already active' do
      let!(:lawyer) { create :lawyer, :with_password, :with_confirmed }
      before { post '/lawyer', lawyer: { name: lawyer.name, email: lawyer.email }, policy_agreement: '1' }

      it { expect(response).to redirect_to('/lawyer/sign_in') }
    end

    context 'without policy agreement' do
      let!(:lawyer) { create :lawyer }
      before { post '/lawyer', lawyer: { name: lawyer.name, email: lawyer.email } }
      it { expect(response).to render_template('lawyers/registrations/new') }
      it { expect(flash[:error]).to eq('您尚未勾選同意條款') }
    end

  end

end
