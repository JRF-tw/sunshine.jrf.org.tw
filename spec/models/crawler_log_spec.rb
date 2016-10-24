# == Schema Information
#
# Table name: crawler_logs
#
#  id                 :integer          not null, primary key
#  crawler_history_id :integer
#  crawler_kind       :integer
#  crawler_error_type :integer
#  crawler_errors     :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe CrawlerLog, type: :model do
  let(:crawler_log) { create :crawler_log }

  context 'FactoryGirl' do
    context 'defualt' do
      it { expect(crawler_log).not_to be_new_record }
    end
  end
end
