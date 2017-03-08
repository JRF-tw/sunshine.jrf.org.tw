json.verdicts @verdicts do |verdict|
  json.set! 'judge_word', verdict.judge_word
  json.set! 'court_name', @court.full_name
  json.set! 'court_code', @court.code
  json.set! 'story_summary', verdict.summary
  json.set! 'date', verdict.date
  json.set! 'judges_names', verdict.judges_names
  json.set! 'prosecutor_names', verdict.prosecutor_names
  json.set! 'lawyer_names', verdict.lawyer_names
  json.set! 'party_names', verdict.party_names
  json.set! 'related_story', verdict.related_story
  json.set! 'verdict_file_url', verdict.file.url
  json.set! 'verdict_content_url', verdict.content_file.url
end
