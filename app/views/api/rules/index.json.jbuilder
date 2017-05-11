json.story do
  json.partial! 'api/story', story: @story
end
json.court do
  json.partial! 'api/court', court: @court
end
json.rules @rules do |rule|
  json.reason rule.reason
  json.judges_names rule.judges_names
  json.lawyer_names rule.lawyer_names
  json.prosecutor_names rule.prosecutor_names
  json.party_names rule.party_names
  json.adjudged_on rule.adjudged_on
  json.original_url rule.original_url
  json.body do
    json.raw_html_url rule.file.url ? smart_add_https(rule.file.url) : nil
    json.content_url rule.content_file.url ? smart_add_https(rule.content_file.url) : nil
  end
end
