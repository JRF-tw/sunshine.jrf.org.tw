require "rails_helper"

describe Bystander::SendSetPasswordEmailContext do

  describe "perform" do
    context "success" do
      let!(:bystander) { FactoryGirl.create :bystander }
      subject { described_class.new(bystander) }

      it { expect { subject.perform }.not_to change { subject.errors } }
      it { expect { subject.perform }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
    end
  end
end
