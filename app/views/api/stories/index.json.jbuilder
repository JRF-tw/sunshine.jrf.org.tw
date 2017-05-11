json.pagination @pagination_data
json.stories @stories do |story|
  json.partial! 'api/story', story: story
  json.court do
    json.partial! 'api/court', court: story.court
  end
end
