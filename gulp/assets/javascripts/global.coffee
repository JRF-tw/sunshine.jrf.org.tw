carousel   = require './carousel'
mobile_nav = require './mobile_nav'
to_top     = require './to_top'
accordions = require './accordions'
modernizr  = require './modernizr'

$(document).on 'page:change', ->
  modernizr()
  carousel()
  mobile_nav()
  to_top()
  accordions()