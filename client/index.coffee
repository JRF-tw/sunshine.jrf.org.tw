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
# { HomeBanners, HomeCover } = require "./entry/home"

# Inject SVG Sprite
sprites = require.context "icons", off
sprites.keys().forEach sprites

$(document).on "page:change", ->
  new Toggle '.switch'
  new Dismiss('[data-dismiss]').init()
  new TextInput()

  $main_header = $('#main-header')
  $('.card__heading').waypoint
    handler: (direction) ->
      if direction is 'down'
        $main_header.addClass 'has-background'
      else
        $main_header.removeClass 'has-background'
    offset: -> $main_header.height()
