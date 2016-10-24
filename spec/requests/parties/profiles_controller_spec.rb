require 'rails_helper'

RSpec.describe Parties::ProfilesController, type: :request do
  before { signin_party }

  describe '#show' do
    subject! { get '/party/profile' }
    it { expect(response).to be_success }
  end

  describe '#edit' do
    subject! { get '/party/profile/edit' }
    it { expect(response).to be_success }
  end

  describe '#update' do
    subject { put '/party/profile', party: { name: party_name } }

    context 'success' do
      let(:party_name) { '當事人一號' }
      it { expect(subject).to redirect_to('/party/profile') }
    end

    context 'empty name' do
      let(:party_name) { '' }
      it { expect(subject).to render_template('edit') }
    end
  end
end
