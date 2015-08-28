carousel   = require './carousel'
mobile_nav = require './mobile_nav'
to_top     = require './to_top'

$(document).on 'page:change', ->
  carousel()
  mobile_nav()
  to_top()