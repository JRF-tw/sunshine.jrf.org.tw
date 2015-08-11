require 'rails_helper'

RSpec.describe Punishment, type: :model do
  let!(:punishment){ FactoryGirl.create :punishment }

  it "FactoryGirl" do
    expect(punishment).not_to be_new_record
  end

  it "has_many :punishment, :dependent => :destroy" do
    expect(Punishment.count).to eq(1)
    profile = punishment.profile
    profile.destroy
    expect(Punishment.count).to be_zero
  end
end
