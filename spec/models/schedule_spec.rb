# == Schema Information
#
# Table name: schedules
#
#  id              :integer          not null, primary key
#  story_id        :integer
#  court_id        :integer
#  branch_name     :string
#  date            :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  branch_judge_id :integer
#

require "rails_helper"

RSpec.describe Schedule do
  let(:schedule) { create :schedule }

  describe "FactoryGirl" do
    context "normalize" do
      subject! { schedule }
      it { expect(subject).not_to be_new_record }
    end

    context "with branch judge" do
      let(:schedule) { create :schedule, :with_branch_judge }
      subject { schedule }
      it { expect(subject).not_to be_new_record }
    end
  end
end
