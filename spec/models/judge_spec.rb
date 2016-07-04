require "rails_helper"

RSpec.describe Judge do
  let(:judge) { FactoryGirl.create :judge }

  describe "FactoryGirl" do
    describe "normalize" do
      subject! { judge }
      it { expect(subject).not_to be_new_record }
    end

    describe "with_avatar" do
      let(:judge) { FactoryGirl.create :judge, :with_avatar }
      subject! { judge }
      it { expect(judge.avatar).to be_present }
    end
  end
end
