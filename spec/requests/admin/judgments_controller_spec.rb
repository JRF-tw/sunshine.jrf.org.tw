require 'rails_helper'

RSpec.describe Admin::JudgmentsController do
  before { signin_user }

  describe 'already had a judgment' do
    let(:judgment) { create :judgment }

    it 'GET /admin/judgments' do
      get '/admin/judgments'
      expect(response).to be_success
    end

    it 'GET /admin/judgments/new' do
      get '/admin/judgments/new'
      expect(response).to be_success
    end

    it 'GET /admin/judgments/123/edit' do
      get "/admin/judgments/#{judgment.id}/edit"
      expect(response).to be_success
    end

    it 'PUT /admin/judgments/123' do
      expect {
        put "/admin/judgments/#{judgment.id}", admin_judgment: { judge_no: 'haha' }
      }.to change { judgment.reload.judge_no }.to('haha')
      expect(response).to be_redirect
    end

    it 'DELETE /admin/judgments/123' do
      delete "/admin/judgments/#{judgment.id}"
      expect(Judgment.count).to be_zero
    end
  end

  it 'POST /admin/judgments' do
    create :court
    admin_judgment = { court_id: Court.last.id, judge_no: 'foo', judge_date_in_tw: '103/8/8' }
    expect {
      post '/admin/judgments', admin_judgment: admin_judgment
    }.to change { Judgment.count }.by(1)
    expect(response).to be_redirect
    expect(Judgment.last.judge_date.year).to eq 2014
  end
end
