require 'rails_helper'

RSpec.describe JudgeVerdict, type: :model do
  let(:judge_verdict){ FactoryGirl.create :judge_verdict }

  describe "FactoryGirl" do
    context "normalize" do
      subject!{ judge_verdict }
      it { expect(subject).not_to be_new_record }
    end
  end
end
