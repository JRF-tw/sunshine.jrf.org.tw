require 'rails_helper'

RSpec.describe Admin::ProceduresController do
  let!(:suit) { create :suit }

  before { signin_user }

  describe 'already had a procedure' do
    let!(:procedure) { create :procedure, suit: suit }

    it 'GET /admin/suits/suit.id/procedures' do
      get "/admin/suits/#{suit.id}/procedures"
      expect(response).to be_success
    end

    it 'GET /admin/suits/suit.id/procedures/new' do
      get "/admin/suits/#{suit.id}/procedures/new"
      expect(response).to be_success
    end

    it 'GET /admin/suits/suit.id/procedures/123/edit' do
      get "/admin/suits/#{suit.id}/procedures/#{procedure.id}/edit"
      expect(response).to be_success
    end

    it 'PUT /admin/suits/suit.id/procedures/123' do
      expect {
        put "/admin/suits/#{suit.id}/procedures/#{procedure.id}", admin_procedure: { title: 'haha' }
      }.to change { procedure.reload.title }.to('haha')
      expect(response).to be_redirect
    end

    it 'DELETE /admin/suits/suit.id/procedures/123' do
      delete "/admin/suits/#{suit.id}/procedures/#{procedure.id}"
      expect(Procedure.count).to be_zero
    end
  end

  it 'POST /admin/suits/suit.id/procedures' do
    suit_judge = create :suit_judge
    admin_procedure = { suit_id: suit_judge.suit_id, profile_id: suit_judge.profile_id, unit: 'foo', title: 'bar', procedure_unit: 'haha', procedure_content: 'hoho', procedure_date: Time.zone.today }
    expect {
      post "/admin/suits/#{suit_judge.suit_id}/procedures", admin_procedure: admin_procedure
    }.to change { Procedure.count }.by(1)
    expect(response).to be_redirect
  end
end
