require 'rails_helper'

RSpec.describe BaseController, :type => :request do
  it "GET /" do
    get "/"
    expect(response).to be_success
    expect(response_meta_title).to be_present
  end
end
