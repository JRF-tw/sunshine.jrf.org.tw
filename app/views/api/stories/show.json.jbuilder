json.story do
  json.partial! 'info', story: @story
  json.schedules do
    json.detail_url api_schedules_url(@court.code, @story.identity, protocol: 'https')
  end
  json.verdict do
    json.detail_url api_verdict_url(@court.code, @story.identity, protocol: 'https')
  end
end
