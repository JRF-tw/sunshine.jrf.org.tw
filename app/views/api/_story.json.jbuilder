json.story do
  json.partial! 'api/stories/identity', story: story
  json.adjudge_date story.adjudge_date
  json.pronounce_date story.pronounce_date
  json.judges_names story.judges_names
  json.prosecutor_names story.prosecutor_names
  json.lawyer_names story.lawyer_names
  json.party_names story.party_names
  json.detail_url api_story_url(story.court.code, story.identity)
end
