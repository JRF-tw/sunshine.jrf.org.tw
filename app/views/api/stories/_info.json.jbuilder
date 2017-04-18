json.partial! 'identity', story: story
json.partial! 'api/court', court: story.court
json.adjudged_on story.adjudged_on
json.pronounced_on story.pronounced_on
json.judges_names story.judges_names
json.prosecutor_names story.prosecutor_names
json.lawyer_names story.lawyer_names
json.party_names story.party_names
