# Require Stylesheets
require "stylesheets"

# Require Modernizr
require "modernizr"

# Require Lazysizes
# require "lazysizes/plugins/custommedia/ls.custommedia"
# require "lazysizes/plugins/respimg/ls.respimg"
# require "lazysizes"

require 'waypoints/lib/jquery.waypoints'

# Require Custom Modules
# Modal = require "./modules/modal"
{Toggle, Dismiss} = require './modules/toggle'
{TextInput}       = require './modules/form'

# Require entry modules
# EX:
StoryCollapse = require "./entry/stories"

# Inject SVG Sprite
sprites = require.context "icons", off
sprites.keys().forEach sprites

$(document).on "page:change", ->
  new Toggle '.switch'
  new Dismiss('[data-dismiss]').init()
  new TextInput()
  new StoryCollapse '#story-collapse-toggle'

  # Stuck Header
  $main_header = $('#main-header')
  $('.card__heading').waypoint
    handler: (direction) ->
      if direction is 'down'
        $main_header.addClass 'has-background'
      else
        $main_header.removeClass 'has-background'
    offset: -> $main_header.height()

  # Datepicker
  $("input.datepicker").each (input) ->
    $(@).datepicker
      dateFormat: "yy-mm-dd"
      altField: $(@).next()

    # If you use i18n-js you can set the locale like that
    # $(this).datepicker "option", $.datepicker.regional[I18n.currentLocale()];

