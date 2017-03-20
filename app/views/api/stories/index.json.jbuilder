json.pagination @pagination_data

json.stories @stories do |story|
  json.story_type story.story_type
  json.year story.year
  json.word_type story.word_type
  json.number story.number
  json.adjudge_date story.adjudge_date
  json.pronounce_date story.pronounce_date
  json.court_name story.court.full_name
  json.court_code story.court.code
  json.judges_names story.judges_names
  json.prosecutor_names story.prosecutor_names
  json.lawyer_names story.lawyer_names
  json.party_names story.party_names
  json.detail_link api_story_url(story.court.code, story.identity)
  json.schedules do
  end
  json.vedrict do
  end
end
