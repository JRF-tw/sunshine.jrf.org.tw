require 'rails_helper'

describe StoryRelationCreateContext do
  let!(:story) { create :story, party_names: ['party'], lawyer_names: ['lawyer'], judges_names: ['judge'] }
  subject { described_class.new(story) }

  context 'create party' do
    let!(:party) { create :party, name: 'party' }

    it { expect { subject.perform(story.party_names.first) }.to change { party.story_relations.count } }
  end

  context 'create lawyer' do
    let!(:lawyer) { create :lawyer, name: 'lawyer' }

    it { expect { subject.perform(story.lawyer_names.first) }.to change { lawyer.story_relations.count } }
  end

  context 'create judge' do
    let!(:judge) { create :judge, name: 'judge' }

    it { expect { subject.perform(story.judges_names.first) }.to change { judge.story_relations.count } }
  end

  context 'name not in story' do
    it { expect(subject.perform('xxx')).to be_falsey }
  end

  context 'name has many people' do
    let!(:judge) { create_list :judge, 2, name: 'judge' }
    it { expect(subject.perform(story.judges_names.first)).to be_falsey }
  end
end
