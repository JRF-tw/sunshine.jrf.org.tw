require 'rails_helper'

describe Admin::CourtCreateContext do
  let(:params) { attributes_for(:court_for_params) }

  context "success" do
    subject { described_class.new(params) }
    it { expect { subject.perform }.to change { Court.count }.by(1) }
  end

  context "aleady has the same name" do
    let!(:court) { FactoryGirl.create :court_for_params }
    subject { described_class.new(params) }
    it { expect { subject.perform }.not_to change { Court.count } }
  end
end
