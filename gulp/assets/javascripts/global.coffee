carousel   = require './carousel'
mobile_nav = require './mobile_nav'
to_top     = require './to_top'
accordions = require './accordions'

$(document).on 'page:change', ->
  carousel()
  mobile_nav()
  to_top()
  accordions()