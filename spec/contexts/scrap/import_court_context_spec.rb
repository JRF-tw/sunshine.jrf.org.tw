require 'rails_helper'

RSpec.describe Scrap::ImportCourtContext, :type => :model do
  describe "#perform" do
    subject{ described_class.perform }
    it { expect{ subject }.to change{ Court.count } }
  end

  describe ".perform" do
    let(:data_hash) { { fullname: "xxx", code: "TTT" } }
    subject!{ described_class.new(data_hash).perform }

    it { expect(subject.full_name).to eq(data_hash[:fullname]) }
    it { expect(subject.code).to eq(data_hash[:code]) }
  end
end
