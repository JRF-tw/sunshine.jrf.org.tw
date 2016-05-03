require 'rails_helper'

RSpec.describe LawyerVerdict, type: :model do
  let(:lawyer_verdict){ FactoryGirl.create :lawyer_verdict }

  describe "FactoryGirl" do
    context "normalize" do
      subject!{ lawyer_verdict }
      it { expect(subject).not_to be_new_record }
    end
  end
end
