# == Schema Information
#
# Table name: verdicts
#
#  id               :integer          not null, primary key
#  story_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  file             :string
#  party_names      :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  is_judgment      :boolean          default(FALSE)
#  adjudge_date     :date
#  main_judge_id    :integer
#  main_judge_name  :string
#  publish_date     :date
#

require 'rails_helper'

RSpec.describe Verdict do
  let(:verdict) { create :verdict }

  describe 'FactoryGirl' do
    context 'normalize' do
      subject! { verdict }
      it { expect(subject).not_to be_new_record }
    end

    context 'with_main_judge' do
      let(:verdict) { create :verdict, :with_main_judge }
      subject! { verdict }
      it { expect(subject).not_to be_new_record }
    end
  end
end
