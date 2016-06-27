require 'rails_helper'

RSpec.describe ScoresController, type: :request do

  describe "#index" do
    subject! { get "/scores"}
    it { expect(response).to be_success }
  end

end
