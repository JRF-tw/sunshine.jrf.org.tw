require 'rails_helper'

RSpec.describe Admin::ProsecutorsController do
  before { signin_user }
  let!(:prosecutor) { create :prosecutor }

  describe '#index' do
    context 'render success' do
      before { get '/admin/prosecutors' }
      it { expect(response).to be_success }
    end

    context 'search the prosecutors_office of prosecutor' do
      before { get '/admin/prosecutors', q: { prosecutors_office_id_eq: prosecutor.prosecutors_office_id } }
      it { expect(response.body).to match(prosecutor.name) }
    end
  end

  describe '#new' do
    context 'render success' do
      before { get '/admin/prosecutors/new' }
      it { expect(response).to be_success }
    end
  end

  describe '#edit' do
    context 'render edit success' do
      before { get "/admin/prosecutors/#{prosecutor.id}/edit" }
      it { expect(response).to be_success }
    end
  end

  describe '#update' do
    context 'update success' do
      subject { put "/admin/prosecutors/#{prosecutor.id}", admin_prosecutor: { name: '笑笑' } }
      it { expect { subject }.to change { prosecutor.reload.name }.to('笑笑') }
      it { expect(response).to be_redirect }
    end
  end

  describe '#delete' do
    context 'delete success' do
      subject { delete "/admin/prosecutors/#{prosecutor.id}" }
      it { expect { subject }.to change { Prosecutor.count }.by(-1) }
      it { expect(response).to be_redirect }
    end
  end

  describe '#create' do
    context 'create success' do
      subject { post '/admin/prosecutors', admin_prosecutor: { name: '笑笑' } }
      it { expect { subject }.to change { Prosecutor.count }.by(1) }
      it { expect(response).to be_redirect }
    end
  end

  describe '#set_to_judge' do
    context 'success' do
      subject { post "/admin/prosecutors/#{prosecutor.id}/set_to_judge" }

      it { expect { subject }.to change { prosecutor.reload.is_active } }
      it { expect(subject).to eq(302) }
    end
  end

end
