json.partial! 'api/stories/info', story: story
json.detail_url api_story_url(story.court.code, story.identity)
