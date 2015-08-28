carousel   = require './carousel'
mobile_nav = require './mobile_nav'

$(document).on 'page:change', ->
  carousel()
  mobile_nav()