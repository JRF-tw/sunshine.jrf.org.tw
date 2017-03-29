# == Schema Information
#
# Table name: schedule_scores
#
#  id                  :integer          not null, primary key
#  schedule_id         :integer
#  judge_id            :integer
#  schedule_rater_id   :integer
#  schedule_rater_type :string
#  data                :hstore
#  appeal_judge        :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  story_id            :integer
#  attitude_scores     :hstore
#  command_scores      :hstore
#

FactoryGirl.define do
  factory :schedule_score do
    story { FactoryGirl.create :story }
    schedule { FactoryGirl.create :schedule, story: story }
    judge { FactoryGirl.create :judge }
    schedule_rater { FactoryGirl.create :lawyer }
    trait :by_party do
      schedule_rater { FactoryGirl.create :party }
    end

    trait :without_schedule do
      schedule nil
    end

    trait :with_start_on do
      after(:create) do |schedule_score|
        schedule_score.start_on = Schedule.last.start_on
        schedule_score.save
      end
    end

    trait :with_adjudged_story do
      story { FactoryGirl.create :story, :adjudged }
    end
  end

  factory :schedule_score_for_params, class: ScheduleScore do
    court_id { FactoryGirl.create(:court).id }
    year '2016'
    word_type '聲'
    number '105'
    story_type '民事'
    start_on Time.zone.today
    judge_name 'xxx'
    confirmed_realdate false
    score_1_1 '2'
    score_1_2 '2'
    score_1_3 '2'
    score_2_1 '2'
    score_2_2 '2'
    score_2_3 '2'
    score_2_4 '2'
    score_2_5 '2'
    note 'xxxxx'
    appeal_judge false
  end

  factory :schedule_score_for_update_no_command_params, class: ScheduleScore do
    score_1_1 '2'
    score_1_2 '2'
    score_1_3 '2'
    note 'xxxxx'
    appeal_judge false
  end

  factory :schedule_score_for_update_no_attitute_params, class: ScheduleScore do
    score_2_1 '2'
    score_2_2 '2'
    score_2_3 '2'
    score_2_4 '2'
    score_2_5 '2'
    note 'xxxxx'
    appeal_judge false
  end

  factory :schedule_score_for_update_params, class: ScheduleScore do
    score_1_1 '2'
    score_1_2 '2'
    score_1_3 '2'
    score_2_1 '2'
    score_2_2 '2'
    score_2_3 '2'
    score_2_4 '2'
    score_2_5 '2'
    note 'xxxxx'
    appeal_judge false
  end

end
