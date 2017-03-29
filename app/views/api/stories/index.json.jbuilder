json.pagination @pagination_data

json.stories @stories do |story|
  json.partial! 'info', story: story
  json.detail_link api_story_url(story.court.code, story.identity, protocol: 'https')
end
