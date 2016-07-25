require "rails_helper"

describe Admin::LawyerUpdateContext do
  let!(:lawyer) { create :lawyer }
  subject { described_class.new(lawyer) }

  context "success" do
    let(:params) { attributes_for(:lawyer, :with_gender) }
    it { expect { subject.perform(params) }.to change { lawyer.gender }.to eq(params[:gender]) }
  end

  context "name can't be empty" do
    let(:empty_name_params) { attributes_for(:empty_name_for_lawyer) }
    it { expect { subject.perform(empty_name_params) }.not_to change { lawyer } }
  end

  context "update won't send confirmation email" do
    it { expect { subject.perform(email: "1234@example.com") }.not_to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
  end

  context "update email without confirm" do
    it { expect { subject.perform(email: "1234@example.com") }.to change { lawyer.email } }
  end
end
