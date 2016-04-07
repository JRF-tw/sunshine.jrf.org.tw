require 'rails_helper'

RSpec.describe LawyerStory do
  let(:lawyer_story){ FactoryGirl.create :lawyer_story }

  describe "FactoryGirl" do
    describe "normalize" do
      subject!{ lawyer_story }
      it { expect(subject).not_to be_new_record }
    end
  end
end
