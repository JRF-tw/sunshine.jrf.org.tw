require "rails_helper"

describe Lawyer::SendSetPasswordEmailContext do

  describe "perform" do
    context "success" do
      let!(:lawyer) { create :lawyer }
      subject { described_class.new(lawyer) }

      it { expect { subject.perform }.not_to change { subject.errors } }
      it { expect { subject.perform }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
    end

  end
end
