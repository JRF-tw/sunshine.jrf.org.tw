json.verdicts @verdicts do |verdict|
  json.set! '裁判字號', verdict.judge_word
  json.set! '法院名稱', @court.full_name
  json.set! '法院代號', @court.code
  json.set! '案由', verdict.summary
  json.set! '日期', verdict.date
  json.set! '法官姓名', verdict.judges_names
  json.set! '檢察官姓名', verdict.prosecutor_names
  json.set! '律師姓名', verdict.lawyer_names
  json.set! '當事人姓名', verdict.party_names
  json.set! '相關案件字號', verdict.related_story
  json.set! '判決書檔案連結', verdict.file.url
  json.set! '判決書主文連結', verdict.content_file.url
end
