# 匯入法院
csv_file = "#{Rails.root}/app/lib/import/court_judges.csv"
lines = File.read(csv_file).split("\n")
lines.each_with_index do |line, i|
  weight = lines.length - i
  r = line.split(",")
  Court.create(court_type: "法院", full_name: r[0], name: r[1], weight: weight, is_hidden: false)
end

# 匯入檢察署
csv_file = "#{Rails.root}/app/lib/import/court_prosecutors.csv"
lines = File.read(csv_file).split("\n")
lines.each_with_index do |line, i|
  weight = lines.length - i
  r = line.split(",")
  Court.create(court_type: "檢察署", full_name: r[0], name: r[1], weight: weight, is_hidden: false)
end