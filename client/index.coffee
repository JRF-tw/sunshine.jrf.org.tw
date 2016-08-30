# Require Stylesheets
require "stylesheets"

# Require Modernizr
require "modernizr"

# Require Lazysizes
# require "lazysizes/plugins/custommedia/ls.custommedia"
# require "lazysizes/plugins/respimg/ls.respimg"
# require "lazysizes"

require 'waypoints/lib/jquery.waypoints'
require 'webui-popover/dist/jquery.webui-popover.js'

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

  # Let cached input value trigger 'is-focus'
  $('.form-control:not([autofocus])').trigger 'blur'

  # Datepicker
  $("input.datepicker").each (input) ->
    $(@).datepicker
      dateFormat: "yy-mm-dd"
      altField: $(@).next()
      onClose: -> $(@).trigger 'blur'

  # Popover
  $('.popover-trigger').webuiPopover()
