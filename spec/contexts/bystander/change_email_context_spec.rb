require "rails_helper"

describe Bystander::ChangeEmailContext do
  let!(:bystander) { FactoryGirl.create :bystander }

  describe "perform" do
    context "success" do
      let(:params) { { email: "h2312@gmail.com", current_password: "123123123" } }
      subject { described_class.new(bystander) }

      it { expect { subject.perform(params) }.to change { bystander.reload.unconfirmed_email } }
    end

    context "update the same email" do
      let(:params) { { email: bystander.email, current_password: "123123123" } }
      subject { described_class.new(bystander) }

      it { expect { subject.perform(params) }.not_to change { bystander.reload.unconfirmed_email } }
    end

    context "update other's unconfirmed_email" do
      let!(:bystander2) { FactoryGirl.create :bystander, :with_unconfirmed_email }
      let(:params) { { email: bystander2.unconfirmed_email, current_password: "123123123" } }
      subject { described_class.new(bystander) }

      it { expect { subject.perform(params) }.not_to change { bystander.reload.unconfirmed_email } }
    end

    context "empty password" do
      let(:params) { { email: bystander.email, current_password: "" } }
      subject { described_class.new(bystander) }

      it { expect { subject.perform(params) }.not_to change { bystander.reload.unconfirmed_email } }
    end
  end

end
