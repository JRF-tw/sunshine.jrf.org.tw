object @profiles
node(:count) { |_| @profiles_count }
child(:@profiles) do
  attributes :id, :name, :current, :gender, :gender_source, :birth_year, :birth_year_source, :stage, :stage_source
  attributes :appointment, :appointment_source, :memo, :current_court
  attributes avatar_url: :avatar
  child(:educations) do
    attributes :id, :title, :content, :start_at, :end_at, :source, :memo
  end
  child(:careers) do
    attributes :id, :career_type, :old_unit, :old_title, :old_assign_court, :old_assign_judicial, :old_pt, :new_unit
    attributes :new_title, :new_assign_court, :new_assign_judicial, :new_pt, :start_at, :end_at, :publish_at
    attributes :source, :source_link, :origin_desc, :memo
  end
  child(:licenses) do
    attributes :id, :license_type, :unit, :title, :publish_at, :source, :source_link, :origin_desc, :memo
  end
  child(:awards) do
    attributes :id, :award_type, :unit, :content, :publish_at, :source, :source_link, :origin_desc, :memo
  end
  child(:punishments) do
    attributes :id, :decision_unit, :unit, :title, :claimant, :punish_no, :decision_no, :punish_type, :relevant_date
    attributes :decision_result, :decision_source, :reason, :is_anonymous, :anonymous_source, :anonymous, :origin_desc
    attributes :proposer, :plaintiff, :defendant, :reply, :reply_source, :punish, :content, :summary, :memo, :status
  end
end
node(:status) {"success"}