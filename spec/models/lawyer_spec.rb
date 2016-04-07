require 'rails_helper'

RSpec.describe Lawyer  do
  let(:lawyer){ FactoryGirl.create :lawyer }

  describe "FactoryGirl" do
    describe "normalize" do
      subject!{ lawyer }
      it { expect(subject).not_to be_new_record }
    end

    describe "with_avatar" do
      let(:lawyer){ FactoryGirl.create :lawyer, :with_avatar }
      subject!{ lawyer }
      it { expect(lawyer.avatar).to be_present }
    end
  end
end
