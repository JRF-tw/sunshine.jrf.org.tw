# == Schema Information
#
# Table name: judgments
#
#  id                 :integer          not null, primary key
#  court_id           :integer
#  main_judge_id      :integer
#  presiding_judge_id :integer
#  judge_no           :string
#  court_no           :string
#  judge_type         :string
#  judge_date         :date
#  reason             :text
#  content            :text
#  comment            :text
#  source             :text
#  source_link        :text
#  memo               :text
#  created_at         :datetime
#  updated_at         :datetime
#  is_hidden          :boolean
#

require "rails_helper"

RSpec.describe Judgment, type: :model do
  let!(:judgment) { create :judgment }

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
    judgment_judge = create :judgment_judge
    judgment = judgment_judge.judgment
    expect(judgment.judges.last.current.to_s).to eq("法官")
  end
end
