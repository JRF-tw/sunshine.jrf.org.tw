json.story do
  json.partial! 'info', story: @story
  json.partial! 'api/court', court: @story.court
  json.schedules do
    json.detail_url api_schedules_url(@court.code, @story.identity)
  end
  json.verdict do
    json.detail_url api_verdict_url(@court.code, @story.identity)
  end
end
