require 'rails_helper'

describe Lawyer::SendSetPasswordEmailContext do

  describe "perform" do
    context "success" do
      let!(:lawyer) { FactoryGirl.create :lawyer }
      subject { described_class.new(lawyer) }

      it { expect { subject.perform }.not_to change { subject.errors } }
      it { expect { subject.perform }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
    end

    context "already confirmed" do
      let!(:lawyer) { FactoryGirl.create :lawyer, :with_password_and_confirmed }
      subject { described_class.new(lawyer) }

       it { expect { subject.perform }.to change { subject.errors } }
      it { expect { subject.perform }.not_to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
    end
    
  end
end
