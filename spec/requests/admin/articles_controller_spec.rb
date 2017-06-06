require 'rails_helper'

RSpec.describe Admin::ArticlesController do
  let!(:judge) { create :judge }

  before { signin_user }

  describe 'already had a article' do
    let!(:article) { create :article, owner: judge }

    it 'GET /admin/judges/judge.id/articles' do
      get "/admin/judges/#{judge.id}/articles"
      expect(response).to be_success
    end

    it 'GET /admin/judges/judge.id/articles/new' do
      get "/admin/judges/#{judge.id}/articles/new"
      expect(response).to be_success
    end

    it 'GET /admin/judges/judge.id/articles/123/edit' do
      get "/admin/judges/#{judge.id}/articles/#{article.id}/edit"
      expect(response).to be_success
    end

    it 'PUT /admin/judges/judge.id/articles/123' do
      expect {
        put "/admin/judges/#{judge.id}/articles/#{article.id}", article: { article_type: 'haha' }
      }.to change { article.reload.article_type }.to('haha')
      expect(response).to be_redirect
    end

    it 'DELETE /admin/judges/judge.id/articles/123' do
      delete "/admin/judges/#{judge.id}/articles/#{article.id}"
      expect(Article.count).to be_zero
    end
  end

  it 'POST /admin/judges/judge.id/articles' do
    attrs = attributes_for(:article)
    attrs.delete :paper_publish_at
    attrs[:paper_publish_at_in_tw] = '104/9/10'
    expect {
      post "/admin/judges/#{judge.id}/articles", article: attrs
    }.to change { Article.count }.by(1)
    expect(response).to be_redirect
    expect(Article.last.paper_publish_at_in_tw).to eq '104/9/10'
  end
end
