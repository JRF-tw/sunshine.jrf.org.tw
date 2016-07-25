require "rails_helper"

RSpec.describe CourtObserver, type: :model do
  let(:court_observer) { create :court_observer }

  it "FactoryGirl" do
    expect(court_observer).not_to be_new_record
  end
end
