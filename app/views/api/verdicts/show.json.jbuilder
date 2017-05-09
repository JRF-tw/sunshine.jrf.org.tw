json.verdict do
  json.story do
    json.partial! 'api/story', story: @story
  end
  json.partial! 'api/court', court: @court
  json.reason @verdict.reason
  json.judges_names @verdict.judges_names
  json.lawyer_names @verdict.lawyer_names
  json.prosecutor_names @verdict.prosecutor_names
  json.party_names @verdict.party_names
  json.adjudged_on @verdict.adjudged_on
  json.original_url @verdict.original_url
  json.body do
    json.raw_html_url @verdict.file.url ? smart_add_https(@verdict.file.url) : nil
    json.content_url @verdict.content_file.url ? smart_add_https(@verdict.content_file.url) : nil
  end
end
