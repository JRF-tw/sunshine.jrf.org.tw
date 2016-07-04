require 'rails_helper'

RSpec.describe Verdict do
  let(:verdict) { FactoryGirl.create :verdict }

  describe "FactoryGirl" do
    context "normalize" do
      subject! { verdict }
      it { expect(subject).not_to be_new_record }
    end

    context "with_main_judge" do
      let(:verdict) { FactoryGirl.create :verdict, :with_main_judge }
      subject! { verdict }
      it { expect(subject).not_to be_new_record }
    end
  end
end
