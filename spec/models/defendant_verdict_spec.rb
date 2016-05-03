require 'rails_helper'

RSpec.describe DefendantVerdict, type: :model do
  let(:defendant_verdict){ FactoryGirl.create :defendant_verdict }

  describe "FactoryGirl" do
    context "normalize" do
      subject!{ defendant_verdict }
      it { expect(subject).not_to be_new_record }
    end
  end
end
