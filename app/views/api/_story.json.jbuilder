json.story do
  json.partial! 'api/stories/identity', story: story
  json.adjudged_on story.adjudged_on
  json.pronounced_on story.pronounced_on
  json.judges_names story.judges_names
  json.prosecutor_names story.prosecutor_names
  json.lawyer_names story.lawyer_names
  json.party_names story.party_names
  json.detail_url api_story_url(story.court.code, story.identity, protocol: 'https')
end
