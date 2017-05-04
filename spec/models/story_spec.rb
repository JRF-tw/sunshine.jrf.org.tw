# == Schema Information
#
# Table name: stories
#
#  id               :integer          not null, primary key
#  court_id         :integer
#  story_type       :string
#  year             :integer
#  word_type        :string
#  number           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  party_names      :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  is_adjudged      :boolean          default(FALSE)
#  adjudged_on      :date
#  pronounced_on    :date
#  is_pronounced    :boolean          default(FALSE)
#  is_calculated    :boolean          default(FALSE)
#  reason           :string
#  schedules_count  :integer          default(0)
#

require 'rails_helper'

RSpec.describe Story do
  let(:story) { create :story }

  describe 'FactoryGirl' do
    describe 'normalize' do
      subject! { story }
      it { expect(story).not_to be_new_record }
    end
  end

  describe '#identity' do
    let(:story) { create :story, story_type: '少年', year: 100, word_type: '耶', number: 100 }
    it { expect(story.identity).to eq('少年-100-耶-100') }
  end

  describe '#by_relation_role' do
    context 'judge' do
      let(:judge) { create :judge }
      before { create :story_relation, story: story, people: judge }

      it { expect(story.by_relation_role('judge').first.people).to eq(judge) }
    end

    context 'lawyer' do
      let(:lawyer) { create :lawyer }
      before { create :story_relation, story: story, people: lawyer }

      it { expect(story.by_relation_role('lawyer').first.people).to eq(lawyer) }
    end

    context 'parties' do
      let(:party) { create :party }
      before { create :story_relation, story: story, people: party }

      it { expect(story.by_relation_role('party').first.people).to eq(party) }
    end

    context 'prosecutor' do
      let(:prosecutor) { create :prosecutor }
      before { create :story_relation, story: story, people: prosecutor }

      it { expect(story.by_relation_role('prosecutor').first.people).to eq(prosecutor) }
    end
  end

end
