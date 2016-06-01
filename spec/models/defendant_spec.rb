require 'rails_helper'

RSpec.describe Defendant, type: :model do
  let(:defendant){ FactoryGirl.create :defendant }

  it "FactoryGirl" do
    expect(defendant).not_to be_new_record
  end

  describe "#set_reset_password_token" do
    context "generate reset token" do
      subject! { defendant.set_reset_password_token }
      it { expect(defendant.reload.reset_password_token).to be_present }
      it { expect(defendant.reload.reset_password_sent_at).to be_present }
    end
  end
end
