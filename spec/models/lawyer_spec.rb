require "rails_helper"

RSpec.describe Lawyer do
  let(:lawyer) { FactoryGirl.create :lawyer }

  describe "FactoryGirl" do
    describe "normalize" do
      subject! { lawyer }
      it { expect(subject).not_to be_new_record }
    end

    describe "with_avatar" do
      let(:lawyer) { FactoryGirl.create :lawyer, :with_avatar }
      subject! { lawyer }
      it { expect(lawyer.avatar).to be_present }
    end

    describe "#need_update_info?" do
      subject { lawyer.update_attributes(phone_number: nil) }
      it { expect { subject }.to change { lawyer.reload.need_update_info? }.from(false).to(true) }
    end
  end

  context "devise async" do
    context "create not send confirm email" do
      subject { lawyer }
      it { expect { subject }.not_to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
    end
  end
end
