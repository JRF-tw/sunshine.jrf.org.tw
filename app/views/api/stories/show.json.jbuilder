json.story do
  json.partial! 'info', story: @story
  json.schedules do
    # TODO : schedules index url
  end
  json.vedrict do
    # TODO : verdict show url
  end
end
