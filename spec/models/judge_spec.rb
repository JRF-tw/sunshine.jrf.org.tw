# == Schema Information
#
# Table name: judges
#
#  id                 :integer          not null, primary key
#  name               :string
#  current_court_id   :integer
#  avatar             :string
#  gender             :string
#  gender_source      :string
#  birth_year         :integer
#  birth_year_source  :string
#  stage              :integer
#  stage_source       :string
#  appointment        :string
#  appointment_source :string
#  memo               :string
#  is_active          :boolean          default(TRUE)
#  is_hidden          :boolean          default(TRUE)
#  punishments_count  :integer          default(0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require "rails_helper"

RSpec.describe Judge do
  let(:judge) { create :judge }

  describe "FactoryGirl" do
    describe "normalize" do
      subject! { judge }
      it { expect(subject).not_to be_new_record }
    end

    describe "with_avatar" do
      let(:judge) { create :judge, :with_avatar }
      subject! { judge }
      it { expect(judge.avatar).to be_present }
    end
  end
end
