carousel                 = require './carousel'
mobile_nav               = require './mobile_nav'
to_top                   = require './to_top'
suit_procedure_accordion = require './suit_procedure_accordion'

$(document).on 'page:change', ->
  carousel()
  mobile_nav()
  to_top()
  suit_procedure_accordion()