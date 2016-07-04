# == Schema Information
#
# Table name: judgments
#
#  id                 :integer          not null, primary key
#  court_id           :integer
#  main_judge_id      :integer
#  presiding_judge_id :integer
#  judge_no           :string(255)
#  court_no           :string(255)
#  judge_type         :string(255)
#  judge_date         :date
#  reason             :text
#  content            :text
#  comment            :text
#  source             :string(255)
#  source_link        :string(255)
#  memo               :text
#  created_at         :datetime
#  updated_at         :datetime
#

require "rails_helper"

RSpec.describe Judgment, type: :model do
  let!(:judgment) { FactoryGirl.create :judgment }

  it "FactoryGirl" do
    expect(judgment).not_to be_new_record
  end

  it "Admin::Judgment validate#at_least_has_a_no" do
    judgment2 = Admin::Judgment.create court_id: judgment.court_id
    expect(judgment2.save).to be_falsey
    judgment2.court_no = "baabaa"
    expect(judgment2.save).to be_truthy
  end

  it "has_many :judges" do
    judgment_judge = FactoryGirl.create :judgment_judge
    judgment = judgment_judge.judgment
    expect(judgment.judges.last.current.to_s).to eq("法官")
  end
end
