# Require Stylesheets
require "stylesheets"

# Require Modernizr
require "modernizr"

require 'waypoints/lib/jquery.waypoints'
require 'webui-popover/dist/jquery.webui-popover.js'
require 'chosen-js'
require 'slick-carousel'

# Require Custom Modules
# Modal = require "./modules/modal"
{ Collapse, StoryInjection } = require './modules/stories'
{ Toggle, Dismiss } = require './modules/toggle'
{ TextInput }       = require './modules/form'
Rules               = require './modules/rules'
ToTop               = require './modules/to_top'
Tab                 = require './modules/tab'
Arrow               = require './modules/arrow'

# Require entry modules
# EX:
require './entry/article'

# Inject SVG Sprite
sprites = require.context "icons", off
sprites.keys().forEach sprites

Turbolinks.enableProgressBar()
Turbolinks.enableTransitionCache()

new TextInput()
new StoryInjection '[data-story-inject]'
new Collapse '#story-collapse-toggle'
new Tab '[data-tab-content]'
new Rules()

$(document).on 'ready page:load', ->
  # Datepicker
  $("input.datepicker").each (input) ->
    $(@).datepicker
      dateFormat: "yy-mm-dd"
      altField: $(@).next()
      onClose: -> $(@).trigger 'blur'

  # Active class toggle
  new Toggle '.switch'
  new Dismiss '[data-dismiss]'

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
    autoplaySpeed: 5000
    appendArrows: '.base-hero'
    prevArrow: Arrow.prev 'base-hero-carousel'
    nextArrow: Arrow.next 'base-hero-carousel'

$(document).on "page:change", ->
  # Let cached input value trigger 'is-focus'
  $('input.form-control:not([autofocus], :hidden)').trigger 'blur'

  # Stuck Header
  Waypoint.destroyAll()

  $main_header = $('#main-header')

  $('.base-hero-carousel__cell .heading,
     .card__heading,
     .character-selector__heading,
     .profile__avatar,
     .billboard__heading').waypoint
    handler: (direction) ->
      if direction is 'down'
        $main_header.addClass 'has-background'
      else
        $main_header.removeClass 'has-background'
    offset: -> $main_header.height()

###*
 * 評分星星
###

$(document)
  .on 'mouseenter', '.form-group--score [type="radio"]', (e) ->
    $(@).addClass 'hover'
  .on 'mouseleave', '.form-group--score [type="radio"]', (e) ->
    $(@).removeClass 'hover'

###*
 * 評鑑紀錄 table
###

$(document).on 'click', '.story-list__table tbody tr', (e) ->
  Turbolinks.visit $('td:last a', e.currentTarget).attr 'href'
