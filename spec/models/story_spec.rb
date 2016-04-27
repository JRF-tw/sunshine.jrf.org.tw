require 'rails_helper'

RSpec.describe Story do
  let(:story){ FactoryGirl.create :story }

  describe "FactoryGirl" do
    describe "normalize" do
      subject!{ story }
      it { expect(story).not_to be_new_record }
    end
  end

  context "story_detail" do
    let(:stroy1) { FactoryGirl.create :story ,year: 100, word_type: "耶", number: 100}
    it { expect(stroy1.story_detail).to eq("100-耶-100") }
  end
end
