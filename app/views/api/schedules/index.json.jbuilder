json.schedules @schedules do |schedule|
  json.story_identity @story.identity
  json.court_name @court.full_name
  json.court_code @court.code
  json.branch_name schedule.branch_name
  json.branch_judge schedule.branch_judge.try(:name)
  json.courtroom schedule.courtroom
  json.start_on schedule.start_on
  json.start_at schedule.start_at.try(:to_s)
end
