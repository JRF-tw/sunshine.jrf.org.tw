require 'rails_helper'

RSpec.describe Branch do
  let(:branch) { FactoryGirl.create :branch }

  describe "FactoryGirl" do
    describe "normalize" do
      subject! { branch }
      it { expect(subject).not_to be_new_record }
    end
  end
end
