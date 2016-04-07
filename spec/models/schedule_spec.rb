require 'rails_helper'

RSpec.describe Schedule do
  let(:schedule){ FactoryGirl.create :schedule }

  describe "FactoryGirl" do
    describe "normalize" do
      subject!{ schedule }
      it { expect(subject).not_to be_new_record }
    end
  end
end
