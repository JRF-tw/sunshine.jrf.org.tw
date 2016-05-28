require 'rails_helper'

RSpec.describe Defendant, type: :model do
  let(:defendant){ FactoryGirl.create :defendant }

  it "FactoryGirl" do
    expect(defendant).not_to be_new_record
  end
end
