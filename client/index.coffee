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
require 'slick-carousel'

# Require Custom Modules
# Modal = require "./modules/modal"
{Toggle, Dismiss} = require './modules/toggle'
{TextInput}       = require './modules/form'
StoryCollapse     = require './modules/stories'
Rules             = require './modules/rules'
ToTop             = require './modules/to_top'
Tab               = require './modules/tab'

# Require entry modules
# EX:

# Inject SVG Sprite
sprites = require.context "icons", off
sprites.keys().forEach sprites

new TextInput()
new StoryCollapse '#story-collapse-toggle'
new Toggle '.switch'
new Tab '[data-tab-content]'
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
    search_contains: on

  # Popover
  $('.popover-trigger').webuiPopover()

  # To Top
  new ToTop '#to-top'

  # Base carousel
  $('#base-hero-carousel').slick
    dots: false
    infinite: true
    speed: 300
    fade: true
    cssEase: 'linear'
    adaptiveHeight: false
    slidesToShow: 1
    autoplay: true
    autoplaySpeed: 3000
    arrows: false

$(document).on "page:change", ->
  # Let cached input value trigger 'is-focus'
  $('input.form-control:not([autofocus], :hidden)').trigger 'blur'

  # Stuck Header
  Waypoint.destroyAll()

  $main_header = $('#main-header')
  
  $('.card__heading,
     .character-selector__heading,
     .profile__avatar,
     .billboard__heading').waypoint
    handler: (direction) ->
      if direction is 'down'
        $main_header.addClass 'has-background'
      else
        $main_header.removeClass 'has-background'
    offset: -> $main_header.height()
