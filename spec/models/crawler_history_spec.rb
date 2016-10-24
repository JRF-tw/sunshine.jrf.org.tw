# == Schema Information
#
# Table name: crawler_histories
#
#  id              :integer          not null, primary key
#  crawler_on      :date
#  courts_count    :integer          default(0), not null
#  branches_count  :integer          default(0), not null
#  judges_count    :integer          default(0), not null
#  verdicts_count  :integer          default(0), not null
#  schedules_count :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe CrawlerHistory, type: :model do
  let(:crawler_history) { create :crawler_history }

  context 'FactoryGirl' do
    context 'default' do
      it { expect(crawler_history).not_to be_new_record }
    end
  end
end
