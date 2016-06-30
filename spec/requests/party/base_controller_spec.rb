require 'rails_helper'

RSpec.describe Party::BaseController, type: :request do
  describe "#set_phone?" do
    context "phone_number nil should redirect" do
      before { signin_party.update_attributes(phone_number: nil) }
      subject!{ get "/party/profile" }

      it { expect(response).to redirect_to("/party/phone/new") }
    end
  end
end
