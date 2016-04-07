require 'rails_helper'

RSpec.describe Story do
  let(:story){ FactoryGirl.create :story }

  describe "FactoryGirl" do
    describe "normalize" do
      subject!{ story }
      it { expect(story).not_to be_new_record }
    end
  end
end
