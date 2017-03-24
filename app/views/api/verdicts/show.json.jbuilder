json.verdict do
  json.partial! 'api/stories/identity', story: @story
  json.partial! 'api/court', court: @court
  json.summary @verdict.summary
  json.date @verdict.date
  json.judges_names @verdict.judges_names
  json.prosecutor_names @verdict.prosecutor_names
  json.lawyer_names @verdict.lawyer_names
  json.party_names @verdict.party_names
  json.related_story @verdict.related_story
  json.publish_on @verdict.publish_on
  json.body do
    json.verdict_file_url @verdict.file.url
    json.verdict_content_url @verdict.content_file.url
  end
end
