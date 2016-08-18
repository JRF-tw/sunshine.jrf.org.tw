# Require Stylesheets
require "stylesheets"

# Require Modernizr
require "modernizr"

# Require Lazysizes
# require "lazysizes/plugins/custommedia/ls.custommedia"
# require "lazysizes/plugins/respimg/ls.respimg"
# require "lazysizes"

# Require Custom Modules
# Modal = require "./modules/modal"
Toggle       = require './modules/toggle'
{TextInput}  = require './modules/form'

# Require entry modules
# EX:
# { HomeBanners, HomeCover } = require "./entry/home"

# Inject SVG Sprite
sprites = require.context "icons", off
sprites.keys().forEach sprites

$(document).on "page:change", ->
  new Toggle '.switch'
  new TextInput()