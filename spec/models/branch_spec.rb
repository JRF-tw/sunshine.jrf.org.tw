# == Schema Information
#
# Table name: branches
#
#  id           :integer          not null, primary key
#  court_id     :integer
#  judge_id     :integer
#  name         :string
#  chamber_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  missed       :boolean          default(FALSE)
#

require "rails_helper"

RSpec.describe Branch do
  let(:branch) { create :branch }

  describe "FactoryGirl" do
    describe "normalize" do
      subject! { branch }
      it { expect(subject).not_to be_new_record }
    end
  end
end
