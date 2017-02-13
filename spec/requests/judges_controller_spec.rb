require 'rails_helper'

RSpec.describe JudgesController, type: :request do
  let!(:judge) { create :judge, is_hidden: false }
  describe '#show' do
    subject! { get "/judges/#{judge.id}" }
    it { expect(response).to be_success }
  end

end
