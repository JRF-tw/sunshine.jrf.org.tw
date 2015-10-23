carousel   = require './carousel'
mobile_nav = require './mobile_nav'
to_top     = require './to_top'
accordions = require './accordions'
modernizr  = require './modernizr'
tab        = require './tab'
turbolinks = require './turbolinks'

$(document).on 'page:change', ->
  modernizr()
  mobile_nav()
  to_top()
  accordions()
  tab()
  turbolinks()

carousel()