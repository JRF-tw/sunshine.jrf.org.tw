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
#  adjudged_on      :date
#  published_on     :date
#  content_file     :string
#  crawl_data       :hstore
#  roles_data       :hstore
#  reason           :string
#  related_stories  :text
#  abs_url          :string
#

require 'rails_helper'

RSpec.describe Verdict do
  let(:verdict) { create :verdict }

  describe 'FactoryGirl' do
    context 'normalize' do
      subject! { verdict }
      it { expect(subject).not_to be_new_record }
    end
  end
end
