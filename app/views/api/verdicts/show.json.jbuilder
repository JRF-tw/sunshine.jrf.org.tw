json.verdict do
  json.judgement_number @verdict.judge_word
  json.court_name @court.full_name
  json.court_code @court.code
  json.summary @verdict.summary
  json.date @verdict.date
  json.judges_names @verdict.judges_names
  json.prosecutor_names @verdict.prosecutor_names
  json.lawyer_names @verdict.lawyer_names
  json.party_names @verdict.party_names
  json.related_story @verdict.related_story
  json.body do
    json.verdict_file_url @verdict.file.url
    json.verdict_content_url @verdict.content_file.url
  end
end
