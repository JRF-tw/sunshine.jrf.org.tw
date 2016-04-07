require 'rails_helper'

RSpec.describe Verdict do
  let(:verdict){ FactoryGirl.create :verdict }

  describe "FactoryGirl" do
    describe "normalize" do
      subject!{ verdict }
      it { expect(subject).not_to be_new_record }
    end
  end
end
