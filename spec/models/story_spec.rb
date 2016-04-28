require 'rails_helper'

RSpec.describe Story do
  let(:story){ FactoryGirl.create :story }

  describe "FactoryGirl" do
    describe "normalize" do
      subject!{ story }
      it { expect(story).not_to be_new_record }
    end
  end

  context "#identity" do
    let(:stroy1) { FactoryGirl.create :story ,year: 100, word_type: "耶", number: 100}
    it { expect(stroy1.identity).to eq("100-耶-100") }
  end
end
