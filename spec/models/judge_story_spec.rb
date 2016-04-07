require 'rails_helper'

RSpec.describe JudgeStory do
  let(:judge_story){ FactoryGirl.create :judge_story }

  describe "FactoryGirl" do
    describe "normalize" do
      subject!{ judge_story }
      it { expect(subject).not_to be_new_record }
    end
  end
end
