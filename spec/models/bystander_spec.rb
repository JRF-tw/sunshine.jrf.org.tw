require 'rails_helper'

RSpec.describe Bystander, type: :model do
  let(:bystander){ FactoryGirl.create :bystander }

  it "FactoryGirl" do
    expect(bystander).not_to be_new_record
  end
end
