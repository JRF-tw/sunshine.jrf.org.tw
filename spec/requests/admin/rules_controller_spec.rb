require 'rails_helper'

RSpec.describe Admin::RulesController do
  before { signin_user }

  describe '#index' do
    let!(:rule) { create :rule }

    context 'render success' do
      before { get '/admin/rules' }
      it { expect(response).to be_success }
    end

    context 'search the adjudged_on' do
      before { get '/admin/rules', q: { adjudged_on_eq: rule.adjudged_on } }
      it { expect(response.body).to match(rule.story.court.full_name) }
    end

    context 'search by story id' do
      before { get '/admin/rules', q: { story_id_eq: rule.story.id } }
      it { expect(response.body).to match(rule.story.court.full_name) }
      it { expect(response.body).to match(rule.story.detail_info) }
    end

    context 'search unexist_judges_names' do
      let!(:rule1) { create :rule, judges_names: ['xxxx'] }
      before { get '/admin/rules', q: { unexist_judges_names: 1 } }
      it { expect(response.body).to match(rule.story.court.full_name) }
      it { expect(response.body).not_to match(rule1.judges_names.first) }
    end
  end

  describe '#show' do
    let!(:rule) { create :rule }
    before { get "/admin/rules/#{rule.id}" }

    it { expect(response).to be_success }
  end

  describe '#download_file' do
    let!(:rule) { create :rule, :with_file }

    context 'search the content of rules' do
      before { get "/admin/rules/#{rule.id}/download_file" }
      it { expect(response).to be_success }
    end
  end
end
