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
require 'chosen-js'

# Require Custom Modules
# Modal = require "./modules/modal"
{Toggle, Dismiss} = require './modules/toggle'
{TextInput}       = require './modules/form'
StoryCollapse     = require './modules/stories'
Rules             = require './modules/rules'

# Require entry modules
# EX:

# Inject SVG Sprite
sprites = require.context "icons", off
sprites.keys().forEach sprites

new TextInput()
new StoryCollapse '#story-collapse-toggle'
new Toggle '.switch'
new Dismiss '[data-dismiss]'
new Rules()

$(document).on 'ready page:load', ->
  # Datepicker
  $("input.datepicker").each (input) ->
    $(@).datepicker
      dateFormat: "yy-mm-dd"
      altField: $(@).next()
      onClose: -> $(@).trigger 'blur'

  # Chosen
  $('select').chosen
    no_results_text: '沒有選項符合'

  # Popover
  $('.popover-trigger').webuiPopover()

$(document).on "page:change", ->
  # Let cached input value trigger 'is-focus'
  $('input.form-control:not([autofocus], :hidden)').trigger 'blur'

  # Stuck Header
  Waypoint.destroyAll()

  $main_header = $('#main-header')
  
  $('.card__heading, .character-selector__heading').waypoint
    handler: (direction) ->
      if direction is 'down'
        $main_header.addClass 'has-background'
      else
        $main_header.removeClass 'has-background'
    offset: -> $main_header.height()
