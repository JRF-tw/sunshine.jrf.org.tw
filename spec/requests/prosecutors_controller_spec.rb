require 'rails_helper'

RSpec.describe ProsecutorsController, type: :request do
  let!(:prosecutor) { create :prosecutor }
  describe '#show' do
    subject! { get "/prosecutors/#{prosecutor.id}" }
    it { expect(response).to be_success }
  end

end
