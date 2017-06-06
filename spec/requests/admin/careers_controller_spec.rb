require 'rails_helper'

RSpec.describe Admin::CareersController do
  let!(:judge) { create :judge }

  before { signin_user }

  describe 'already had a career' do
    let!(:career) { create :career, owner: judge }

    it 'GET /admin/judges/judge.id/careers' do
      get "/admin/judges/#{judge.id}/careers"
      expect(response).to be_success
    end

    it 'GET /admin/judges/judge.id/careers/new' do
      get "/admin/judges/#{judge.id}/careers/new"
      expect(response).to be_success
    end

    it 'GET /admin/judges/judge.id/careers/123/edit' do
      get "/admin/judges/#{judge.id}/careers/#{career.id}/edit"
      expect(response).to be_success
    end

    it 'PUT /admin/judges/judge.id/careers/123' do
      expect {
        put "/admin/judges/#{judge.id}/careers/#{career.id}", career: { career_type: 'haha' }
      }.to change { career.reload.career_type }.to('haha')
      expect(response).to be_redirect
    end

    it 'DELETE /admin/judges/judge.id/careers/123' do
      delete "/admin/judges/#{judge.id}/careers/#{career.id}"
      expect(Career.count).to be_zero
    end
  end

  it 'POST /admin/judges/judge.id/careers' do
    expect {
      post "/admin/judges/#{judge.id}/careers", career: attributes_for(:career)
    }.to change { Career.count }.by(1)
    expect(response).to be_redirect
  end
end
