# == Schema Information
#
# Table name: rules
#
#  id               :integer          not null, primary key
#  story_id         :integer
#  file             :string
#  party_names      :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  published_on     :date
#  content_file     :string
#  crawl_data       :hstore
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  reason           :string
#  related_stories  :text
#  abs_url          :string
#  adjudge_date     :date
#

require 'rails_helper'

RSpec.describe Rule do
  let(:rule) { create :rule }

  describe 'FactoryGirl' do
    context 'normalize' do
      subject! { rule }
      it { expect(subject).not_to be_new_record }
    end
  end
end
