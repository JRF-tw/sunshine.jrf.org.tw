json.courts @courts do |court|
  json.partial! 'api/court', court: court
end
