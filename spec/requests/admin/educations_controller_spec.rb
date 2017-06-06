require 'rails_helper'

RSpec.describe Admin::EducationsController do
  let!(:judge) { create :judge }

  before { signin_user }

  describe 'already had a education' do
    let!(:education) { create :education, owner: judge }

    it 'GET /admin/judges/judge.id/educations' do
      get "/admin/judges/#{judge.id}/educations"
      expect(response).to be_success
    end

    it 'GET /admin/judges/judge.id/educations/new' do
      get "/admin/judges/#{judge.id}/educations/new"
      expect(response).to be_success
    end

    it 'GET /admin/judges/judge.id/educations/123/edit' do
      get "/admin/judges/#{judge.id}/educations/#{education.id}/edit"
      expect(response).to be_success
    end

    it 'PUT /admin/judges/judge.id/educations/123' do
      expect {
        put "/admin/judges/#{judge.id}/educations/#{education.id}", education: { title: 'haha' }
      }.to change { education.reload.title }.to('haha')
      expect(response).to be_redirect
    end

    it 'DELETE /admin/judges/judge.id/educations/123' do
      delete "/admin/judges/#{judge.id}/educations/#{education.id}"
      expect(Education.count).to be_zero
    end
  end

  it 'POST /admin/judges/judge.id/educations' do
    expect {
      post "/admin/judges/#{judge.id}/educations", education: attributes_for(:education)
    }.to change { Education.count }.by(1)
    expect(response).to be_redirect
  end
end
